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

    # @param nodes [String] nodes
    # @return [Array] xmlとして出力したい要素を格納
    def extract_nodes(nodes)
      parsed_nodes(nodes).map do |node|
        binding.pry
        hash = {}
        path = node.children[1].attribute("href").value
        hash[:path] = path
        hash
      end
    end

    def x_path
      '//*[@id="main-column"]/div[1]/div[2]/div[4]/ul[1]'
    end
  end
end
