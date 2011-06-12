require 'vmc'
require 'rspec'
require 'webmock/rspec'

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def stub_login(status)
  fixture_file = status == :success ? "login_success.txt" : "login_fail.txt"
  stub_request(:post, "http://api.vcap.me/users/foo@example.com/tokens").
          with(:body => {:password => 'foo'}).
          to_return(fixture(fixture_file))
end
