require 'spec_helper'

describe TaskMapper::Provider::Bcx do
  let(:tm) { create_instance }

  describe "#new" do
    it "creates a new TaskMapper instance" do
      expect(tm).to be_a TaskMapper
    end

    it "can be explicitly called as a provider" do
      tm = TaskMapper::Provider::Bcx.new(
        :username => username,
        :password => password
      )
      expect(tm).to be_a TaskMapper
    end
  end
end
