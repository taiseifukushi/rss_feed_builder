require "spec_helper"
require_relative "../../../lib/feeds/builder"

describe Feeds::Builder do
  describe "#call" do
    let(:builder) { described_class.new(parsed_items) }
    let(:parsed_items) { [{ path: "/path/to/item", date: Time.now, title: "Item Title" }] }

    it "builds xml" do
      xml = builder.call
      expect(xml).to be_a(String)
      expect(xml).to include(builder.title)
      expect(xml).to include(builder.description)
    end
  end

  describe "#url" do
    it "returns the URL from the environment" do
      ENV["URL"] = "http://example.com"
      builder = described_class.new([])
      expect(builder.url).to eq("http://example.com")
    end
  end

  describe "#title" do
    it "returns the title from the environment" do
      ENV["TITLE"] = "Example Title"
      builder = described_class.new([])
      expect(builder.title).to eq("Example Title")
    end
  end

  describe "#description" do
    it "returns the description from the environment" do
      ENV["DESCRIPTION"] = "Example Description"
      builder = described_class.new([])
      expect(builder.description).to eq("Example Description")
    end
  end

  describe "#feed_items" do
    it "returns the parsed items" do
      parsed_items = [{ path: "/path/to/item", date: Time.now, title: "Item Title" }]
      builder = described_class.new(parsed_items)
      expect(builder.feed_items).to eq(parsed_items)
    end
  end

  describe "#set_item_link" do
    let(:builder) { described_class.new([]) }

    it "returns a link when the path item is present" do
      ENV["BASE_URL"] = "http://example.com"
      link = builder.send(:set_item_link, "/path/to/item")
      expect(link).to eq("http://example.com/path/to/item")
    end

    it "returns 'failed to extract link.' when the path item is missing" do
      link = builder.send(:set_item_link, "failed to extract link.")
      expect(link).to eq("failed to extract link.")
    end
  end
end
