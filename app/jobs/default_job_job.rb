class DefaultJobJob < ApplicationJob
  queue_as :default

  include DefaultJobJob::TrelloBoard
  include DefaultJobJob::GitCommitsEmail

  #
  #
  TRELLO_BOARD = "trello_board"
  EMAIL_GIT_COMMIT = "email_git_commit"

  #
  #
  after_enqueue do |job|
    puts "[enqueue] Job:#{job} - DefaultJobJob".red
  end

  #
  #
  after_perform do |job|
    puts "[after_perform] Job:#{job} - DefaultJobJob".red
  end


  #
  #
  def perform(type="", *args)
    puts "Performing DefaultJobJob .... #{type}".yellow


    #
    # Get content from a Trello board
    #
    # DefaultJobJob.perform_now "trello_board", TRELLO_BOARD_NAME, LABELS
    #
    #
    if type == DefaultJobJob::TRELLO_BOARD
      get_trello_board_data("YOUR_TRELLO_NAME_HERE", args[0], args[1], args[2])

    #
    # DefaultJobJob.perform_now DefaultJobJob::EMAIL_GIT_COMMIT, AppID, Environment, Count, Query, Version
    #
    elsif type == DefaultJobJob::EMAIL_GIT_COMMIT
      send_git_commits(args[0], args[1], args[2], args[3], args[4], args[5])

    end

  end

end
