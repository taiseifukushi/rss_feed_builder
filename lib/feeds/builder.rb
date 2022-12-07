require_relative "./base"

module Feeds
  class Builder < Base
    def call
      build_xml(feed_items)
    end

    def url
      ENV["URL"]
    end

    def title
      ENV["TITLE"]
    end

    def description
      ENV["DESCRIPTION"]
    end

    def feed_items
      parsed_items
    end

    private

    def build_xml(items_for_feed)
      RSS::Maker.make("2.0") do |maker|
        xss                       = maker.xml_stylesheets.new_xml_stylesheet
        xss.href                  = url
        xss.href                  = ENV["REPOSITORY_URL"]
        maker.channel.title       = title
        maker.channel.description = description
        maker.channel.link        = url
        maker.items.do_sort       = true

        items_for_feed.each_with_index do |_item, _index|
          next if _item.nil?

          maker.items.new_item do |item|
            item.link  = _item[:path] != "failed to extract path." ? "#{ENV['BASE_URL']}#{_item[:path]}" : "failed to extract path."
            item.title = _item[:title]
            item.date  = _item[:date]
          end
        end
      end
    end
  end
end
