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
    end
  end
end
