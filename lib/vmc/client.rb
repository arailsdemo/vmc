require 'vmc/client/authentication'
require 'vmc/client/connection'
require 'vmc/client/errors'
require 'vmc/client/info'
require 'vmc/client/request'

module VMC
  class Client
    attr_accessor :http_adapter, :target_url

    def initialize(auth_token=nil)
      @auth_token = auth_token

      @target_url = VMC::DEFAULT_LOCAL_TARGET
      @http_adapter = :net_http
    end

    include Authentication
    include Connection
    include Info
    include Request
  end
end
