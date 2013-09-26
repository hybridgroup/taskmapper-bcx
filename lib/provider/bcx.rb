module TaskMapper::Provider
  module Bcx
    include TaskMapper::Provider::Base

    class << self
      attr_accessor :username, :password, :api

      def new(auth = {})
        TaskMapper.new(:bcx, auth)
      end
    end

    def provider
      TaskMapper::Provider::Bcx
    end

    def authorize(auth = {})
      @authenticator ||= TaskMapper::Authenticator.new(auth)

      unless auth[:username] && auth[:password]
        message = "Please provide a username and password."
        raise TaskMapper::Exception.new message
      end

      provider.username = auth[:username]
      provider.password = auth[:password]
      configure auth
    end

    def configure(auth)
      provider.api = API.new(auth[:username], auth[:password])
    end

    def valid?
      provider.api.authenticated?
    end
  end
end
