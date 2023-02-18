require "spec_helper"
require_relative "../../../lib/parser/base"

describe Parser::Base do
  let(:instance) { described_class.new }

  describe "#call" do
    it "raises NotImplementedError" do
      expect { instance.call }.to raise_error(NotImplementedError)
    end
  end

  describe "#target_url" do
    it "raises NotImplementedError" do
      expect { instance.target_url }.to raise_error(NotImplementedError)
    end
  end
end
