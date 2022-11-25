module Parser
  class Base
    require "dotenv"
    require "nokogiri" # https://github.com/sparklemotion/nokogiri#parsing-and-querying
    require "open-uri"
    require "dotenv"
    require "pry"

    Dotenv.load

    def call
      raise NotImplementedError
    end

    def target_url
      raise NotImplementedError
    end
  end
end
