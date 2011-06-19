require 'thor'

module VMC
  class Cli < Thor
    protected

    def client
      @client ||= VMC::Client.new(:target_url => config.target)
    end

    def config
      @config ||= VMC::Cli::Config.new
    end
  end
end

require 'vmc/cli/config'
require 'vmc/cli/methods/admin'
require 'vmc/cli/methods/user'
