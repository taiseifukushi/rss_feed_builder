module Feeds
  class Base

    def initialize(updated_xml)
      @time = Time.zone.now
      @updated_xml = updated_xml
    end

    def call
      reise NotImplementedError 
    end

    private
  end
end