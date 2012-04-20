class LandingController < ApplicationController
  def index
  end

  def find_updates
    Update.store_tweets!(params)
    @updates = Update.order('twitter_created_at DESC')
    respond_to do |format|
      format.js
    end
  end
end
