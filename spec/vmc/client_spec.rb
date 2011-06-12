require "spec_helper"

describe VMC::Client do
  describe "#login" do
    def login
      @client = subject
      @auth_token = @client.login('foo@example.com', 'foo')
    end

    context "when successful" do
      before do
        stub_login(:success)
        login
      end

      it "sets the user" do
        @client.user.should == 'foo@example.com'
      end

      it "sets and returns the auth_token" do
        @client.auth_token.should == @auth_token
        @auth_token.should == "valid_auth_token"
      end
    end

    it "raises an exception when failed" do
      stub_login(:failed)
      expect { login }.to raise_error VMC::Client::TargetError
    end
  end
end
