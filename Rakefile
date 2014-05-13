# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "run rlrtbot"
task :runbot => [:environment] do
  bot = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["RLRTBOT_CONSUMER_KEY"]
    config.consumer_secret     = ENV["RLRTBOT_CONSUMER_SECRET"]
    config.access_token        = ENV["RLRTBOT_ACCESS_TOKEN"]
    config.access_token_secret = ENV["RLRTBOT_ACCESS_TOKEN_SECRET"]
  end

  bot.home_timeline.each do |tweet|
    if tweet.text.upcase.include?("RLRT")
      full_tweet = tweet.text
      rlrt_index = full_tweet.upcase.index("RLRT")
      sliced_tweet = full_tweet.slice(rlrt_index, 1000)
      target_username_start = rlrt_index + 5
      sliced_tweet = full_tweet.slice(target_username_start, 1000)
      target_username_length = sliced_tweet.index(" ")
      target_username = full_tweet.slice(target_username_start,target_username_length)
      target_user = bot.user_search(target_username).first

      if bot.friend_ids.include?(target_user.id)
        bot.retweet(tweet.id)
        puts tweet.text
      end
    end
  end
end