# $redis = Redis.new

class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user

    @consumer =  Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token_secret = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end

    @consumer.update(tweet.status)
  end
end