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

$0 = "vmc"
ARGV.clear

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end

def mock_client(stubs={})
  client = double(VMC::Client, stubs)
  VMC::Client.stub(:new) { client }
  client
end

def mock_config(stubs={})
  config = double(VMC::Cli::Config, stubs)
  VMC::Cli::Config.stub(:new) { config }
  config
end