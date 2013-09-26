require 'httparty'

module TaskMapper::Provider
  module Bcx
    class API
      include HTTParty

      attr_reader :username, :password

      base_uri "https://basecamp.com/999999999/api/v1"
      headers "Content-Type" => "Content-Type: application/json; charset=utf-8"

      def initialize(username, password)
        @username = username
        @password = password
        self.class.basic_auth username, password
      end
    end
  end
end

require 'provider/api/auth'
require 'provider/api/projects'
