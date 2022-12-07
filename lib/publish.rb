class Publish
  require_relative "./feeds/builder"
  require_relative "./parser/parser"

  BUILT_FEED_FILE_PATH = "./public/rss_feed.xml".freeze

  attr_reader :build_feed_file_path

  def initialize
    @build_feed_file_path = BUILT_FEED_FILE_PATH
    # @buiit_feed           = build_xml
  end

  def execute
    write_file(build_feed_file_path, build_xml)
  end

  private

  def write_file(file_path, data)
    File.open(file_path, "w") { |f| f.write(data) }
  end

  def parsed_items
    Parser::Parser.new.call
  end

  def build_xml
    Feeds::Builder.new(parsed_items).call
  end
end
