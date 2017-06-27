class API::V1::BitbucketController < ApplicationController
  skip_before_action :verify_authenticity_token

  # slack
  layout false, only: :slack
  before_action :validate_slack_params, :set_params, only: :slack
  include API::V1::Bitbucket::Slack


  #
  # Receives content from:
  #
  # out = `git --no-pager log -50 --pretty="%H|%s|%an|"`
  # curl  --data "data=#{out}&appid=#{options[:appid]}&environment=#{options[:environment]}" http://localhost:3000/api/v1/bitbucket/content
  #
  # ... and update the database.
  #
  #
  def content
    data = {appid:params[:appid], environment:params[:environment]}
    puts "data:#{data}".red

    data[:format] = GitCommit.new().insert_content(params[:data], params[:appid], params[:environment])

    puts " ".yellow
    puts "data:#{data}".yellow

    render json: data, status: 200
  end


  #
  # Show all records in a JSON format
  #
  # Usage:
  # {{localhost}}/api/v1/bitbucket/report/AndroidApp/develop/NUMBER_OF_RECORDS.[email|json|html]?q=[ALM|]&version=[VERSION_NUMBER|]
  #
  # Ex.:
  # {{localhost}}/api/v1/bitbucket/report/AndroidApp/develop/50.html?q=ALM&version=
  #
  def report
    data = { debug: {
              appid:params[:appid],
              environment:params[:environment],
              count:params[:count],
              format:params[:format],
              q:params[:q],
              version:(params[:version].blank? ? AppVersion.get_app_version(params[:appid], params[:environment], false) : params[:version]),
              date: params[:date],
              to:params[:to]
              }
          }

    data[:result] = GitCommit.find_by_appid_env_count(params[:appid], params[:environment], params[:count], params[:q], params[:version], params[:date])

    data[:debug][:count_delivered] = (data[:result] ? data[:result].count : 0)


    #
    #
    if params[:format] == "email"
      if Rails.env == "development"
        DefaultJobJob.new().perform(DefaultJobJob::EMAIL_GIT_COMMIT, 
                                    params[:appid], params[:environment], data[:debug][:count], data[:debug][:q], data[:debug][:version], data[:debug][:to])

      else
        puts "1".red
        puts "appid: #{params[:appid]}".red
        puts "env: #{params[:environment]}".red
        puts "result: #{data[:result]}".red
        DefaultJobJob.perform_later(DefaultJobJob::EMAIL_GIT_COMMIT, 
                                    params[:appid], params[:environment], data[:debug][:count], data[:debug][:q], data[:debug][:version], data[:debug][:to])

      end
      render json: data, status: 200

    elsif params[:format] == "json"
      render json: data, status: 200


    elsif params[:format] == "html"
      @data = data
    end
  end


end
