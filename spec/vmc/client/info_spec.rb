require 'spec_helper'

describe VMC::Client::Info do
  describe ".info" do
    it "obtains user and general info when an auth token is present" do
      stub_request(:get, "http://api.vcap.me/info").
              with(:headers => {'AUTHORIZATION' => 'token'}).
              to_return(fixture('info_authenticated.txt'))

      client = VMC::Client.new('token')
      info = client.info

      info.support.should == "ac-support@vmware.com"
      info.user.should == 'foo@example.com'
    end

    it "obtains just the general info when an auth token is not present" do
      stub_request(:get, "http://api.vcap.me/info").
              to_return(fixture('info_returned.txt'))

      client = VMC::Client.new
      info = client.info

      info.support.should == "ac-support@vmware.com"
      info.user.should be_nil
    end
  end
end
