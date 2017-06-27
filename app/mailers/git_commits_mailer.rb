class GitCommitsMailer < ApplicationMailer
  default from: "your_sender_email@gmail.com"

  #
  #
  def send_email(appid="AndroidApp", environment="develop", version="999", q="", records=[], xto="")
    @appid = appid
    @environment = environment
    @version = version
    @records = records
    @q = q

    if Rails.env == "development"
      to = "your_receiver_email@gmail.com"

    else
      to = "your_receiver_email@gmail.com"
      
    end

    to = "#{to},#{xto}"

    subject = "SUBJECT | #{@appid} - #{@environment} - v.#{@version}"
    if Rails.env == "development"
      subject = "[DEV - #{Time.now.strftime("%y%m%d-%H%M%S")}] #{subject}"
    end

    mail(to:to, subject:subject)
  end

end
