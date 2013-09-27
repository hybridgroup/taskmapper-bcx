require 'spec_helper'

describe TaskMapper::Provider::Bcx::Ticket do
  let(:tm) { create_instance }
  let(:comment_class) { TaskMapper::Provider::Bcx::Comment }
  let(:project) { tm.project 605816632 }
  let(:ticket) { project.ticket 1 }

  describe "#comments" do
    context "with no arguments" do
      let(:comments) { ticket.comments }

      it "returns an array containing all comments" do
        expect(comments).to be_an Array
        expect(comments.first).to be_a comment_class
      end
    end

    context "with an array of comment IDs" do
      let(:comments) { ticket.comments [1028592764] }

      it "returns an array of the matching comments" do
        expect(comments).to be_an Array
        expect(comments.first).to be_a comment_class
        expect(comments.first.id).to eq 1028592764
      end
    end
  end
end
