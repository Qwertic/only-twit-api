# frozen_string_literal: true

module TwitterManager
  class TweetCreator < ApplicationService
    attr_reader :message

    def initialize(message)
      super
      @message = message
    end

    def call
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_TOKEN']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
      end
      puts client.as_json
      client.update(@message)
    end
  end
end
