class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :tweets


  def tweet(status)
    tweet = Tweet.create!(:status => status)
    self.tweets << tweet
    TweetWorker.perform_async(tweet.id)
  end

  def tweet_later(delay, status)
    tweet = Tweet.create!(:status => status)
    self.tweets << tweet
    TweetWorker.delay_until(delay.minutes.from_now).perform_async(tweet.id)
  end
  
end
