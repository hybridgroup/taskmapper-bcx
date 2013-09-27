module TaskMapper::Provider
  module Bcx
    class API
      def create_comment(attributes)
        project = attributes.delete(:project_id)
        todo = attributes.delete(:ticket_id)
        body = { "content" => attributes[:body] }

        url = "/projects#{project}/todos/#{todo}/comments.json"
        self.class.post url, :body => body.to_json
      end
    end
  end
end
