module Feeds
  class Base
    require "dotenv"
    require "rss"
    require "pry"

    Dotenv.load

    attr_reader :current_time, :feed_item

    def initialize(feed_item)
      @current_time = Time.zone.now
      @feed_item    = feed_item
    end

    def call
      raise NotImplementedError
    end

    def url
      raise NotImplementedError
    end

    def title
      raise NotImplementedError
    end

    def description
      raise NotImplementedError
    end

    def items
      raise NotImplementedError
    end
  end
end
