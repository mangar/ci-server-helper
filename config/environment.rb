# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

if ENV['LOGENTRIES_TOKEN']

  Rails.logger = Le.new(ENV['LOGENTRIES_TOKEN'], :debug => true, :local => true)

else
  puts "Warning loading Rails.logger with Logentries. Environment variable (LOGENTRIES_TOKEN) not defined. Not a real problem.".red

end
