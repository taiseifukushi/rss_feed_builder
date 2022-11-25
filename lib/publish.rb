class Publish
  # require_relative "../../lib/message_text.rb"
  # require_relative "../../lib/message_text.rb"

  BUILT_FEED_FILE_PATH = "".freeze

  attr_reader :build_feed_file_path, :build_feed

  def initialize
    @build_feed_file_path = BUILT_FEED_FILE_PATH
    @build_feed           = built_feed
  end

  def execute
    write_file(build_feed_file_path, build_feed)
  end

  private

  def write_file(file_path, data)
    File.open(file_path, "w") { |f| f.write(data) }
  end

  def built_feed
    
  end
end
