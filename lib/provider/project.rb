module TaskMapper::Provider
  module Bcx
    class Project < TaskMapper::Provider::Base::Project
      def updated_at
        Time.parse(self[:updated_at])
      rescue
        self[:updated_at]
      end

      def created_at
        Time.parse(self[:created_at])
      rescue
        self[:created_at]
      end

      class << self
        def find_by_attributes(attributes = {})
          search_by_attribute find_all, attributes
        end

        def find_all
          api.projects.collect { |project| self.new project }
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
