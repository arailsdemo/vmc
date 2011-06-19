require 'spec_helper'

describe VMC::Cli::Config do
  let(:path) { File.expand_path('~/.vmc') }

  describe "#update" do
    context "when a .vmc file doesn't exist" do
      it "creates the file and can add a new token" do
        io = StringIO.new
        expected_tokens = { 'http://api.vcap.me' => 'new_token' }
        File.stub(:exists?).with(path) { false }
        File.stub(:open).with(path, 'w').and_yield(io)
        YAML.should_receive(:dump).with({"tokens" => expected_tokens }, io)

        config = VMC::Cli::Config.new
        config.update(:tokens, 'new_token')
        config.tokens.should == expected_tokens
      end

      it "creates the file and can add a email" do
        io = StringIO.new
        File.stub(:exists?).with(path) { false }
        File.stub(:open).with(path, 'w').and_yield(io)
        YAML.should_receive(:dump).with({"email" => "foo@bar.com" }, io)

        config = VMC::Cli::Config.new
        config.update(:email, 'foo@bar.com')
        config.email.should == 'foo@bar.com'
      end
    end

    context "when a .vmc file exist" do
      it "can update tokens in the .vmc config file" do
        old_token = { 'http://api.vcap.me' => 'old_token' }
        new_tokens = old_token.merge({ "foo/bar" => 'new_token'})
        io = StringIO.new

        File.stub(:exists?).with(path) { true }
        YAML.stub(:load_file).with(path) { { "tokens" => old_token } }
        File.stub(:open).with(path, 'w').and_yield(io)
        YAML.should_receive(:dump).with({ "tokens" => new_tokens }, io)

        config = VMC::Cli::Config.new(:target => 'foo/bar')
        config.update(:tokens, 'new_token')
        config.tokens.should == new_tokens
      end
    end
  end
end
