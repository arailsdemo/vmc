require "spec_helper"

describe VMC::Cli do
  describe "#initialize" do
    it "passes the config target into the client" do
      VMC::Cli::Config.should_receive(:new) { double('Config', :target => 'target') }
      VMC::Client.should_receive(:new).with(:target_url => "target")
      VMC::Cli.new.send(:client)
    end
  end
end
