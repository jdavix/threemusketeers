class Update < ActiveRecord::Base
  attr_accessible :content, :username, :twitter_created_at, :twitter_id

  class << self
    def store_tweets!(params)
      existing_usernames = Update.select("DISTINCT username").where("username IN (?)", params[:usernames].try(:values))
      if existing_usernames.size > 0
        existing_usernames.each do |update|
          latest_update = Update.where("username = ?", update.username).order('twitter_created_at DESC').limit(1).first
          params[:usernames].delete(update.username.to_sym)
          #getting only the latest tweets since the latest twitter id stored for each username
          twitter_updates = Twitter.user_timeline(update.username, :since_id => latest_update.twitter_id)
          twitter_updates.each do |tweet|
            Update.new({:twitter_created_at => tweet.created_at.utc.strftime("%Y-%m-%d %H:%M:%s"), :content => tweet.text, :username => tweet.user.screen_name.downcase, :twitter_id => tweet.id}).save
          end
        end
      end
      params[:usernames].each do |key, value|
        twitter_updates = Twitter.user_timeline(value.downcase)
        twitter_updates.each do |tweet|
          Update.new({:twitter_created_at => tweet.created_at.utc.strftime("%Y-%m-%d %H:%M:%s"), :content => tweet.text, :username => tweet.user.screen_name.downcase, :twitter_id => tweet.id}).save
        end
      end
    end
  end
end
