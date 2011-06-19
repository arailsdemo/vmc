require 'yaml'

module VMC
  class Cli
    class Config
      attr_accessor :config_hash, :settings_path, :target

      def initialize(options={})
        @settings_path = File.expand_path(VMC::DEFAULT_CONFIG_PATH)
        @target = options[:target] || VMC::DEFAULT_LOCAL_TARGET
        @config_hash = load_settings || {}
      end

      def email
        config_hash["email"]
      end

      def tokens
        config_hash["tokens"] || {}
      end

      def update(attr, value)
        if attr == :tokens
          config_hash["tokens"] = tokens.merge({ target => value })
        else
          config_hash[attr.to_s] = value
        end

        File.open(settings_path, 'w') do |out|
          YAML.dump(config_hash, out)
        end
      end

      private

      def load_settings
        File.exists?(settings_path) ? YAML.load_file(settings_path) : nil
      end
    end
  end
end
