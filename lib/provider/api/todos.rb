module TaskMapper::Provider
  module Bcx
    class API
      def todos(project_id)
        todolists = self.class.get "/projects/#{project_id}/todolists.json"
        ids = todolists.collect { |t| t['id'] }
        todos = []
        ids.each do |id|
          list = self.class.get("/projects/#{project_id}/todolists/#{id}.json")
          next if !list.is_a?(Hash) || list["todos"].nil?
          todos << list["todos"]["remaining"]
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
        self.class.post url, :body => body
      end
    end
  end
end
