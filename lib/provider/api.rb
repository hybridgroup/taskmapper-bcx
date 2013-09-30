require 'httparty'

module TaskMapper::Provider
  module Bcx
    class API
      include HTTParty

      attr_reader :account_id, :username, :password

      headers "Content-Type" => "Content-Type: application/json; charset=utf-8"

      def initialize(account_id, username, password)
        @username = username
        @password = password
        @account_id = account_id
        self.class.base_uri "https://basecamp.com/#{account_id}/api/v1"
        self.class.basic_auth username, password
      end
    end
  end
end

require 'provider/api/auth'
require 'provider/api/projects'
require 'provider/api/todos'
require 'provider/api/comments'
