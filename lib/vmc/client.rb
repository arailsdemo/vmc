require 'faraday_middleware'

module VMC
  class Client
    class TargetError < RuntimeError; end

    attr_accessor :auth_token
    attr_reader :user

    def login(username, password)
      connection = Faraday.new(:url => 'http://api.vcap.me') do |builder|
        builder.use Faraday::Request::JSON
        builder.use Faraday::Response::Rashify
        builder.use Faraday::Response::ParseJson

        builder.adapter :net_http
      end

      response = connection.post("/users/#{username}/tokens", :password => password).body

      raise TargetError if response.code == 200
      @user = username
      @auth_token = response.token
    end
  end
end
