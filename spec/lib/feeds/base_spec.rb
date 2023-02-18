require "spec_helper"
require_relative "../../../lib/feeds/base"

RSpec.describe Feeds::Base do
  let(:parsed_items) { double(:parsed_items) }
  subject(:base) { described_class.new(parsed_items) }

  describe "#call" do
    it "raises NotImplementedError" do
      expect { base.call }.to raise_error(NotImplementedError)
    end
  end

  describe "#url" do
    it "raises NotImplementedError" do
      expect { base.url }.to raise_error(NotImplementedError)
    end
  end

  describe "#title" do
    it "raises NotImplementedError" do
      expect { base.title }.to raise_error(NotImplementedError)
    end
  end

  describe "#description" do
    it "raises NotImplementedError" do
      expect { base.description }.to raise_error(NotImplementedError)
    end
  end

  describe "#feed_items" do
    it "raises NotImplementedError" do
      expect { base.feed_items }.to raise_error(NotImplementedError)
    end
  end

  describe "#current_time" do
    it "returns the current time in local time zone" do
      expect(base.current_time).to be_a(Time)
      expect(base.current_time.zone).to eq("+09:00")
    end
  end

  describe "#parsed_items" do
    it "returns the parsed items" do
      expect(base.parsed_items).to eq(parsed_items)
    end
  end
end
