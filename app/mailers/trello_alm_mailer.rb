class TrelloAlmMailer < ApplicationMailer
  default from: "your_sender_email@gmail.com"

  #
  #
  def trello_alm(trello_file, details={}, to="")

    @so = ""
    trello_file.labels.each do |l|
      @so = @so + "#{l.name}, "
    end
    
    @trello_file = trello_file
    @details = details

    #
    if Rails.env == "development"
      @to = (to || "") + ",your_email_here@gmail.com"
    else
      @to = (to || "your_email_here@gmail.com")
    end

    #
    subject = "Report Diário | #{@so}"
    if Rails.env == "development"
      subject = "#{subject} - [DEV - #{Time.now.strftime("%y%m%d-%H%M%S")}]"
    end

    
    mail(to:@to, subject:subject)
  end

end