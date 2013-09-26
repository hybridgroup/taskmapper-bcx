module TaskMapper::Provider
  module Bcx
    class Project < TaskMapper::Provider::Base::Project
      def initialize(*object)
        object = object.first if object.is_a?(Array)
        super object if object.is_a?(Hash)
      end

      def updated_at
        begin
          Time.parse(self[:updated_at])
        rescue
          self[:updated_at]
        end
      end

      def created_at
        begin
          Time.parse(self[:created_at])
        rescue
          self[:created_at]
        end
      end

      class << self
        def find_by_attributes(attributes = {})
          search_by_attribute(self.find_all, attributes)
        end

        def find_all
          projects = api.projects
          projects = projects.select { |project| project.is_a?(Hash) }
          projects.collect { |project| self.new project }
        end

        def find_by_id(id)
          project = api.project(id)
          self.new Hash[project]
        end

        private
        def api
          TaskMapper::Provider::Bcx.api
        end
      end
    end
  end
end
