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
        xss                       = maker.xml_stylesheets.new_xml_stylesheet || "Content is null."
        xss.href                  = ENV["REPOSITORY_URL"]                    || "Content is null."
        maker.channel.title       = title                                    || "Content is null."
        maker.channel.description = description                              || "Content is null."
        maker.channel.link        = url                                      || "Content is null."
        maker.items.do_sort       = true                                     || "Content is null."

        items_for_feed.each do |_item|
          next if _item.nil?

          maker.items.new_item do |item|
            item.link  = set_item_link(_item[:path]) || "Content is null."
            item.date  = _item[:date]  || "Content is null."
            item.title = _item[:title] || "Content is null."
          end
        end
      rescue StandardError => e
        puts "[#{self.class}] failed to build xml: #{e}"
      end
    end

    def set_item_link(path_item)
      return "#{ENV['BASE_URL']}#{path_item}" if path_item != "failed to extract link."

      "failed to extract link."
    end
  end
end
