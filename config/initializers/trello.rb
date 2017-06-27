require 'trello'

puts "=> Trello loading... ".yellow

if ENV['TRELLO_NEXT_PUBLIC_KEY'] && ENV['TRELLO_NEXT_TOKEN']



  @trello = Trello.configure do |config|
    begin
      config.developer_public_key = ENV['TRELLO_NEXT_PUBLIC_KEY']
      config.member_token = ENV['TRELLO_NEXT_TOKEN']  

      @user = Trello::Member.find("YOUR_TRELLO_MEMBER_NAME")
    rescue => exception
      puts "   ups, looks that your Trello credentials is not valid...".red    
    end
    
  end

else
  puts "   problem loading Trello. Env libs not defined".red

  @user = {}
end
