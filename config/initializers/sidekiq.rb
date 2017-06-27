puts "=> Sidekiq loading... ".yellow

puts "   RedisURL: #{ENV['REDIS_URL']}"

Sidekiq.configure_server do |config|
  config.redis = { url: "#{ENV['REDIS_URL']}" }
  # config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/12" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{ENV['REDIS_URL']}" }
  # config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/12" }
end
ENV["REDIS_URL"]
