module TaskMapper::Provider
  module Bcx
    class Comment < TaskMapper::Provider::Base::Comment
      def initialize(*object)
        object = object.first if object.is_a?(Array)
        super object if object.is_a?(Hash)
      end
    end
  end
end
