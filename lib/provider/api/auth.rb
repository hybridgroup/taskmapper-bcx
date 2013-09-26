module TaskMapper::Provider
  module Bcx
    class API
      def authenticated?
        @auth ||= begin
          me = self.class.get "/people/me.json"
          me.is_a?(Hash) && !me['id'].nil?
        end
      end
    end
  end
end
