class API::V1::TrelloController < ApplicationController
  before_action :validate_labels_param
  skip_before_action :verify_authenticity_token

  #
  #
  #
  def all
    data = { debug: { format:params[:format], board:params[:board], labels:params[:labels], to:params[:to] }}

    #
    if Rails.env == "development"
      DefaultJobJob.new().perform(DefaultJobJob::TRELLO_BOARD, params[:board], params[:labels], params[:to])

    else
      DefaultJobJob.perform_later(DefaultJobJob::TRELLO_BOARD, params[:board], params[:labels], params[:to])

    end

    data[:output] = {
      message:"Report under construction. You will receive an email when it's done."
    }

    render json: data, status: 200
  end




private

  #
  #
  def validate_labels_param
    if params[:labels].blank?
      data = {message:"You have to specify the labels parameter with the OS. Ex: ?labels=Android"}
      render json: data, status: 401
      return false
    end
  end


end
