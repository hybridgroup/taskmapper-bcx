module TaskMapper::Provider
  module Bcx
    class Ticket < TaskMapper::Provider::Base::Ticket
      def initialize(*object)
        object = object.first if object.is_a?(Array)
        super object if object.is_a?(Hash)
      end

      def description
        self[:content]
      end

      def description=(string)
        self[:content] = string
      end

      class << self
        def find_by_attributes(project_id, attributes = {})
          search_by_attribute(self.find_all(project_id), attributes)
        end

        def find_all(project_id)
          todos = api.todos project_id
          todos = todos.select { |todo| todo.is_a?(Hash) }
          todos.collect { |todo| self.new todo }
        end

        def find_by_id(project_id, ticket_id)
          todo = api.todo project_id, ticket_id
          self.new Hash[todo]
        end

        def create(attributes)
          todo = api.create_todo attributes
          self.new Hash[todo]
        end

        private
        def api
          TaskMapper::Provider::Bcx.api
        end
      end
    end
  end
end
