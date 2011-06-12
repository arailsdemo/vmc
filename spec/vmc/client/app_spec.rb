require "spec_helper"

describe VMC::Client::App do
  describe "#app_info" do
    it "obtains the given app's info when a valid auth_token is present" do
      stub_request(:get, "http://api.vcap.me/info").
          to_return(fixture('info_authenticated.txt'))
      stub_request(:get, "http://api.vcap.me/apps/my_app").
          with(:headers => {'AUTHORIZATION' => 'token'}).
          to_return(fixture('app_info.txt'))

      client = VMC::Client.new('token', 'my_app')

      client.app_info.resources.memory.should == 64
    end

    it "obtains the given app's info when logged in" do
      stub_login(:success)
      stub_request(:get, "http://api.vcap.me/apps/my_app").
          with(:headers => {'AUTHORIZATION' => 'valid_auth_token'}).
          to_return(fixture('app_info.txt'))

      client = VMC::Client.new(nil, 'my_app')
      client.login('foo@example.com', 'foo')

      client.app_info.resources.memory.should == 64
    end

    it "raises an AuthError if not logged in" do
      stub_request(:get, "http://api.vcap.me/apps/my_app")
      stub_request(:get, "http://api.vcap.me/info").
          to_return(fixture('info_returned.txt'))

      client = VMC::Client.new(nil, 'my_app')
      expect { client.app_info }.to raise_error VMC::Client::AuthError
    end
  end
end
