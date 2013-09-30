module TaskMapper::Provider
  module Bcx
    class API
      def todos(project_id)
        ids = get_todolist_ids project_id
        todo_ids = ids.collect do |id|
          get_todo_ids_from_list project_id, id 
        end.flatten

        todos = []
        todo_ids.each do |id|
          todo = self.class.get "/projects/#{project_id}/todos/#{id}.json"
          todos << Hash[todo]
        end
        todos.flatten
      end

      def todo(project_id, todo_id)
        self.class.get "/projects/#{project_id}/todos/#{todo_id}.json"
      end

      def create_todo(attributes)
        project = attributes.delete(:project_id)
        todolist = attributes.delete(:todolist_id)
        due_at = attributes.delete(:due_at)

        body = { "content" => attributes[:description] }
        body.merge({ "due_at" => due_at.utc.iso8601 }) if due_at

        url = "/projects/#{project}/todolists/#{todolist}/todos.json"
        self.class.post url, :body => body.to_json
      end

      def update_todo(todo)
        body = {
           :content => todo['content'],
           :due_at => todo['due_at'],
           :completed => todo['completed']
        }

        url = "/projects/#{todo['project_id']}/todos/#{todo['id']}.json"
        self.class.put url, :body => body.to_json
      end

      private
      def get_todolist_ids(project_id)
        lists = self.class.get "/projects/#{project_id}/todolists.json"
        lists.collect { |t| t['id'] }
      end

      def get_todo_ids_from_list(project_id, list)
        list = self.class.get "/projects/#{project_id}/todolists/#{list}.json"
        return [] if !list.is_a?(Hash) || list["todos"].nil?
        ids = []
        ids << list["todos"]["remaining"].map { |t| t['id'] }
        ids << list["todos"]["completed"].map { |t| t['id'] }
        ids.flatten
      end
    end
  end
end
