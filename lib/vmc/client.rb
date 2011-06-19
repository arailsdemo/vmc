require 'vmc/client/app'
require 'vmc/client/authentication'
require 'vmc/client/connection'
require 'vmc/client/errors'
require 'vmc/client/info'
require 'vmc/client/request'

module VMC
  class Client
    attr_accessor :app_name, :http_adapter, :target_url

    def initialize(options={})
      @auth_token = options[:auth_token]
      @app_name = options[:app_name]
      @target_url = options[:target_url] || VMC::DEFAULT_LOCAL_TARGET
      @http_adapter = :net_http
    end

    include App
    include Authentication
    include Connection
    include Info
    include Request
  end
end
