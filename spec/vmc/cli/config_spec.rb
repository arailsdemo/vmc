require 'spec_helper'

describe VMC::Cli::Config do
  let(:config) { @config ||= VMC::Cli::Config.new }
  let(:io) { @io ||= StringIO.new }
  let(:path) { File.expand_path('~/.vmc') }

  def stub_config_file(contents=nil)
    File.stub(:exists?).with(path) { contents ? true : false }
    YAML.stub(:load_file).with(path) { contents } if contents
    File.stub(:open).with(path, 'w').and_yield(io)
  end

  describe "#update" do
    context "when a .vmc file doesn't exist" do
      it "creates the file and can add a new token" do
        expected_tokens = { 'http://api.vcap.me' => 'new_token' }
        stub_config_file
        YAML.should_receive(:dump).with({"tokens" => expected_tokens }, io)

        config.update(:tokens, 'new_token')
        config.tokens.should == expected_tokens
      end

      it "creates the file and can add a email" do
        stub_config_file
        YAML.should_receive(:dump).with({"email" => "foo@bar.com" }, io)

        config.update(:email, 'foo@bar.com')
        config.email.should == 'foo@bar.com'
      end
    end

    context "when a .vmc file exist" do
      it "can update tokens in the .vmc config file" do
        old_token = { 'http://api.vcap.me' => 'old_token' }
        new_tokens = old_token.merge({ "foo/bar" => 'new_token'})

        stub_config_file("tokens" => old_token)
        YAML.should_receive(:dump).with({ "tokens" => new_tokens }, io)

        config = VMC::Cli::Config.new(:target => 'foo/bar')
        config.update(:tokens, 'new_token')
        config.tokens.should == new_tokens
      end

      it "uses the target url in the config file" do
        stub_config_file("target" => "foobar.com")
        VMC::Cli::Config.new.target.should == 'foobar.com'
      end
    end
  end
end
