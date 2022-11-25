module Feeds
  class Builder < Base

    def call
      build_xml(items)
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

    private
    
    def build_xml(feed_items)
      RSS::Maker.make("2.0") do |maker|
        xss                       = maker.xml_stylesheets.new_xml_stylesheet
        xss.href                  = url
        xss.href                  = ENV["REPOSITORY_URL"]
        maker.channel.title       = title
        maker.channel.description = description
        maker.channel.link        = url
        maker.items.do_sort       = true

        make_feed_items(feed_items)
      end
    end

    def make_feed_items(feed_items)
      feed_items.each_with_index do |_item, i|
        _item.link  = feed_item
        _item.title = "News #{i+1}" # 本当はタイトルを取得したいけど難しかったので現時点では適当
        _item.date  = current_time # 本当は更新時刻を取得したいけど難しかったので現時点では適当
      end
    end
  end
end
