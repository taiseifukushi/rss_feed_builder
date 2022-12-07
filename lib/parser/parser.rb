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
      hash = {}

      nokogiri_node_sets.map.with_index do |node_set, i|
        next if node_set.class == Nokogiri::XML::Text

        hash[:path]  = extract_title(node_set.children[i])
        hash[:title] = extract_title(node_set.children[i])
        hash[:date]  = extract_date(node_set.children[i])
        hash
      end
    end

    def extract_path(element)
      element.attribute("href").value
    rescue StandardError
      "failed to extract paths."
    end
    
    def extract_title(element)
      element.children[1].children[1].children[1].children[3].children[0]
    rescue StandardError
      "failed to extract title."
    end
    
    def extract_date(element)
      element.children[1].children[1].children[1].children[5].children[0]
    rescue StandardError
      "failed to extract date."
    end

    def x_path
      '//*[@id="article-category-list"]/ul'
    end
  end
end
