module TaskMapper::Provider
  module Bcx
    class Comment < TaskMapper::Provider::Base::Comment
      def initialize(*object)
        object = object.first if object.is_a?(Array)
        super object if object.is_a?(Hash)
      end

      class << self
        def find_by_attributes(project_id, ticket_id, attributes = {})
          search_by_attribute(self.find_all(project_id, ticket_id), attributes)
        end

        def find_by_id(project_id, ticket_id, comment_id)
          ticket = Ticket.find_by_id project_id, ticket_id
          if comment = ticket[:comments].find { |c| c[:id] == comment_id }
            return self.new comment
          else
            return false
          end
        end

        def find_all(project_id, ticket_id)
          ticket = Ticket.find_by_id project_id, ticket_id
          ticket[:comments].collect { |comment| self.new comment }
        end
      end
    end
  end
end
