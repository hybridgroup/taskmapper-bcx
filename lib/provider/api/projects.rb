module TaskMapper::Provider
  module Bcx
    class API
      def projects
        self.class.get "/projects.json"
      end

      def project(id)
        self.class.get "/projects/#{id}.json"
      end
    end
  end
end
