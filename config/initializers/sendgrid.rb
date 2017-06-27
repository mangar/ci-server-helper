puts "=> Sendgrid loading... ".yellow

unless ENV['SENDGRID_USERNAME'] && ENV['SENDGRID_PASSWORD'] && ENV['SENDGRID_API_KEY']
  puts "Sendgrid environment variables not found. SENDGRID_USERNAME, SENDGRID_PASSWORD or SENDGRID_API_KEY".red
end
