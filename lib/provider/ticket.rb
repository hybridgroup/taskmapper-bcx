module TaskMapper::Provider
  module Bcx
    class Ticket < TaskMapper::Provider::Base::Ticket
      def description
        self[:content]
      end

      def description=(string)
        self[:content] = string
      end

      def status
        self[:completed] ? 'closed' : 'open'
      end

      def updated_at
        Time.parse(self[:updated_at])
      rescue
        self[:updated_at]
      end

      def save
        api.update_todo self
      end

      def close
        self[:completed] = true
        save
      end

      def reopen
        self[:completed] = false
        save
      end

      def created_at
        Time.parse(self[:created_at])
      rescue
        self[:created_at]
      end

      class << self
        def find_by_attributes(project_id, attributes = {})
          search_by_attribute find_all(project_id), attributes
        end

        def find_all(project_id)
          todos = api.todos project_id
          todos = todos.select { |todo| todo.is_a? Hash }
          todos.each { |t| t.merge! :project_id => project_id }
          todos.collect { |todo| self.new todo }.flatten
        end

        def find_by_id(project_id, ticket_id)
          todo = api.todo project_id, ticket_id
          todo = Hash[todo].merge(:project_id => project_id)
          self.new todo
        end

        def create(attributes)
          todo = api.create_todo attributes
          todo = Hash[todo].merge(:project_id => attributes[:project_id])
          self.new todo
        end

        private
        def api
          TaskMapper::Provider::Bcx.api
        end
      end

      private
      def api
        TaskMapper::Provider::Bcx.api
      end
    end
  end
end
