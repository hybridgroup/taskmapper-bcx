require 'spec_helper'

describe TaskMapper::Provider::Bcx do
  let(:tm) { create_instance }

  describe "#new" do
    it "creates a new TaskMapper instance" do
      expect(tm).to be_a TaskMapper
    end

    it "can be explicitly called as a provider" do
      tm = TaskMapper::Provider::Bcx.new(
        :account_id => account_id,
        :username => username,
        :password => password
      )
      expect(tm).to be_a TaskMapper
    end
  end

  describe "#valid?" do
    context "with a correctly authenticated Basecamp user" do
      it "returns true" do
        expect(tm.valid?).to be_true
      end
    end

    context "with an invalid Basecamp user" do
      before do
        base = "https://baduser:badpassword@basecamp.com/999999999/api/v1"
        stub_get(base + "/people/me.json", 'invalid_user.txt', 404, 'text/html')
      end

      let(:tm) { create_instance "baduser", "badpassword" }

      it "returns false" do
        expect(tm.valid?).to be_false
      end
    end
  end
end
