require 'spec_helper'

describe TaskMapper::Provider::Bcx::Project do
  let(:tm) { create_instance }
  let(:project_class) { TaskMapper::Provider::Bcx::Project }

  describe "#projects" do
    context "without params" do
      let(:projects) { tm.projects }

      it "returns an array of all projects" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
      end
    end

    context "with an array of IDs" do
      let(:projects) { tm.projects [605816632] }

      it "returns an array of matching projects" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
        expect(projects.first.id).to eq 605816632
      end
    end

    context "with a hash containing an ID" do
      let(:projects) { tm.projects :id => 605816632 }

      it "returns an array containing the matching project" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
        expect(projects.first.id).to eq 605816632
      end
    end
  end
end
