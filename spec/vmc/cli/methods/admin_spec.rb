require "spec_helper"

describe VMC::Cli do
  describe "#target" do
    let(:set_target) { VMC::Cli.start(["target", "foobar.com"]) }

    it "updates the config file with the target url" do
      mock_config.should_receive(:update).with(:target, "foobar.com")
      results = capture(:stdout) { set_target }
      results.should =~ /Target set to foobar.com./
    end

    it "display the current target if not given an argument" do
      mock_config.should_receive(:target) { "hooha.com" }
      results = capture(:stdout) { VMC::Cli.start(["target"]) }
      results.should =~ /Current target is hooha.com./
    end
  end
end
