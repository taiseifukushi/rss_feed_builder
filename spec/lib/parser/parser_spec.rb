require "rspec"
require_relative "../../../lib/parser/parser"

describe Parser::Parser do
  describe "#get_nodes" do
    it "gets nodes from url" do
      parser = Parser::Parser.new
      nodes = parser.send(:get_nodes, parser.target_url)
      expect(nodes).to be_a(Nokogiri::HTML::Document)
    end
  end

  describe "#parsed_nodes" do
    it "parses nodes by x_path" do
      parser = Parser::Parser.new
      nodes = parser.send(:get_nodes, parser.target_url)
      parsed_nodes = parser.send(:parsed_nodes, nodes)
      expect(parsed_nodes).to be_a(Nokogiri::XML::NodeSet)
    end
  end

  describe "#extract_nodes" do
    it "extracts nodes by parsed_nodes" do
      parser = Parser::Parser.new
      nodes = parser.send(:get_nodes, parser.target_url)
      parsed_nodes = parser.send(:parsed_nodes, nodes)
      extracted_nodes = parser.send(:extract_nodes, parsed_nodes)
      expect(extracted_nodes).to be_an(Array)
    end
  end

  describe "#extract_path" do
    it "extracts path from element" do
      parser = Parser::Parser.new
      nodes = parser.send(:get_nodes, parser.target_url)
      parsed_nodes = parser.send(:parsed_nodes, nodes)
      extracted_nodes = parser.send(:extract_nodes, parsed_nodes)
      path = parser.send(:extract_path, extracted_nodes.first)
      expect(path).to be_a(String)
    end
  end

  describe "#extract_title_and_date" do
    let(:parser) { Parser::Parser.new }
    let(:node_set) { Nokogiri::HTML("<div><a href='/example'><p>Title</p><p>Update: 2020/01/01</p></a></div>").children.first }

    it "extracts title and date from a node set" do
      expect(parser.send(:extract_title_and_date, node_set)).to eq({ title: "Title", date: "Update: 2020/01/01" })
    end
  end
end
