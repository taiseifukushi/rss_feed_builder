require "fileutils"
require "rspec"
require_relative "../../lib/publish"

describe Publish do
  let(:file_path) { "./public/rss_feed_test.xml" }

  after do
    FileUtils.rm(file_path) if File.exist?(file_path)
  end

  describe "#parsed_items" do
    it "calls Parser::Parser#call" do
      allow(Parser::Parser).to receive(:new).and_return(parser_double = double)
      expect(parser_double).to receive(:call)

      subject.parsed_items
    end
  end

  describe "#build_xml" do
    it "calls Feeds::Builder#call" do
      allow(subject).to receive(:parsed_items).and_return([])
      allow(Feeds::Builder).to receive(:new).and_return(builder_double = double)
      expect(builder_double).to receive(:call)

      subject.build_xml
    end
  end

  describe "#write_file" do
    it "writes data to file" do
      data = "dummy data"

      subject.send(:write_file, file_path, data)

      expect(File.read(file_path)).to eq data
    end
  end

  describe "#execute" do
    it "writes the built xml data to the file" do
      expect(File.exist?(described_class::BUILT_FEED_FILE_PATH)).to be_falsey

      publish.execute

      expect(File.exist?(described_class::BUILT_FEED_FILE_PATH)).to be_truthy
    end
  end
end
