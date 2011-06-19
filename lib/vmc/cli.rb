require 'thor'

module VMC
  class Cli < Thor
    protected

    def client
      @client ||= VMC::Client.new
    end

    def config
      @config ||= VMC::Cli::Config.new
    end
  end
end

require 'vmc/cli/config'
require 'vmc/cli/methods/user'
