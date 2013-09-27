module TaskMapper::Provider
  module Bcx
    class Comment < TaskMapper::Provider::Base::Comment
      def initialize(*object)
        object = object.first if object.is_a?(Array)
        super object if object.is_a?(Hash)
      end

      def body
        self[:content]
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
        def find_by_attributes(project_id, ticket_id, attributes = {})
          search_by_attribute(self.find_all(project_id, ticket_id), attributes)
        end

        def find_by_id(project_id, ticket_id, comment_id)
          ticket = Ticket.find_by_id project_id, ticket_id
          if comment = ticket[:comments].find { |c| c[:id] == comment_id }
            comment = comment.merge({
              :ticket_id => ticket_id,
              :project_id => project_id
            })
            return self.new comment
          else
            return false
          end
        end

        def find_all(project_id, ticket_id)
          ticket = Ticket.find_by_id project_id, ticket_id
          ticket[:comments].collect do |comment|
            comment = comment.merge({
              :ticket_id => ticket_id,
              :project_id => project_id
            })
            self.new comment
          end
        end

        def create(attributes)
          project = attributes[:project_id]
          ticket = attributes[:ticket_id]

          comment = api.create_comment attributes
          comment = comment.merge({
            :project_id => project,
            :ticket_id => ticket
          })

          self.new comment
        end

        private
        def api
          TaskMapper::Provider::Bcx.api
        end
      end
    end
  end
end
