require 'spec_helper'

describe TaskMapper::Provider::Bcx::Project do
  let(:tm) { create_instance }
  let(:ticket_class) { TaskMapper::Provider::Bcx::Ticket  }
  let(:project) { tm.project 605816632 }

  describe "#tickets" do
    context "with no arguments" do
      let(:tickets) { project.tickets }

      it "returns an array of all tickets" do
        expect(tickets).to be_an Array
        expect(tickets.first).to be_a ticket_class
      end
    end

    context "with an array of ticket IDs" do
      let(:tickets) { project.tickets [1] }

      it "returns an array containing the requested tickets" do
        expect(tickets).to be_an Array
        expect(tickets.first).to be_a ticket_class
        expect(tickets.first.id).to eq 1
      end
    end

    context "with a hash containing a ticket ID" do
      let(:tickets) { project.tickets :id => 1 }

      it "returns an array containing the requested ticket" do
        expect(tickets).to be_an Array
        expect(tickets.first).to be_a ticket_class
        expect(tickets.first.id).to eq 1
      end
    end
  end
end
