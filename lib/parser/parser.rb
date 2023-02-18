require_relative "./base"

module Parser
  class Parser < Base
    def call
      nodes = get_nodes(target_url)
      extract_nodes(nodes)
    end

    def target_url
      ENV["URL"]
    end

    private

    def get_nodes(url)
      Nokogiri::HTML(URI.open(url))
    end

    def parsed_nodes(nodes)
      nodes.xpath(x_path)
    end

    # @param nodes [Nokogiri::HTML4::Document] nodes
    # @return [Array] xmlとして出力したい要素を格納
    def extract_nodes(nodes)
      nokogiri_node_sets = parsed_nodes(nodes)[0].children
      nokogiri_node_sets.each_with_object([]) do |node_set, _array|
        next if node_set.instance_of?(Nokogiri::XML::Text)

        hash = {}
        hash[:path]  = extract_path(node_set)
        hash[:title] = extract_title_and_date(node_set)[:title]
        hash[:date]  = extract_title_and_date(node_set)[:date]
        _array << hash
      end
    end

    def extract_path(element)
      element.children[1].attribute("href").value
    rescue StandardError => e
      "[#{self.class}] failed to extract path: #{e}"
    end

    # @param element [Nokogiri::XML::Element]
    # @return [Hash] titleとdateのキーをもったHashを返す
    def extract_title_and_date(element)
      hash = {}
      _element1 = element.children[1].children[1].children[3].children[0].text
      _element2 = element.children[1].children[1].children[5].children[0].text

      [_element1, _element2].each do |e|
        if time_expression?(e)
          hash[:date] = e
        else
          hash[:title] = e
        end
      end
      hash
    rescue StandardError => e
      "[#{self.class}] failed to extract title and date: #{e}"
    end

    def time_expression?(extract_element)
      time_expression = "更新"
      extract_element.include?(time_expression)
    end

    def x_path
      '//*[@id="article-category-list"]/ul'
    end
  end
end
