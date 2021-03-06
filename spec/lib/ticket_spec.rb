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

  describe "#ticket" do
    context "with a ticket ID" do
      let(:ticket) { project.ticket 1 }

      it "returns the requested ticket" do
        expect(ticket).to be_a ticket_class
        expect(ticket.id).to eq 1
      end
    end

    describe "#close" do
      let(:ticket) { project.tickets.first }

      before do
        expect(TaskMapper::Provider::Bcx::API).to receive(:put).with(
            "/projects/605816632/todos/1.json",
            hash_including(:body)
          )
      end

      it "updates the status and saves the ticket" do
        expect(ticket.status).to eq "open"
        ticket.close
        expect(ticket.status).to eq 'closed'
      end
    end

    describe "#reopen" do
      let(:ticket) { project.tickets.last }

      before do
        expect(TaskMapper::Provider::Bcx::API).to receive(:put).with(
            "/projects/605816632/todos/3.json",
            hash_including(:body)
          )
      end

      it "updates the status and saves the ticket" do
        expect(ticket.status).to eq "closed"
        ticket.reopen
        expect(ticket.status).to eq 'open'
      end
    end
  end

  describe "#ticket!" do
    context "with new ticket params" do
      let(:ticket) do
        project.ticket!(
          :description => "A New Ticket",
          :todolist_id => 968316918
        )
      end

      it "should create a new ticket" do
        expect(ticket).to be_a ticket_class
        expect(ticket.description).to eq "A New Ticket"
        expect(ticket.todolist_id).to eq 968316918
      end
    end
  end
end
