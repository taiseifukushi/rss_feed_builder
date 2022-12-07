module Feeds
  class Base
    require "dotenv"
    require "rss"
    require "pry"

    Dotenv.load

    attr_reader :current_time, :parsed_items

    def initialize(parsed_items)
      utc_time      = Time.now
      @current_time = utc_time.localtime("+09:00")
      @parsed_items = parsed_items
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

    def feed_items
      raise NotImplementedError
    end
  end
end
