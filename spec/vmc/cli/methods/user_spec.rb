require 'spec_helper'

describe VMC::Cli do
  describe "#login" do
    context "when credentials are not provided" do
      let(:login) { VMC::Cli.start(["login"]) }

      it "asks for an email and password" do
        $stdin.should_receive(:gets).and_return('foo@bar.com', 'sekret')
        results = capture(:stdout) { login }
        results.should =~ /Please enter your email:/
        results.should =~ /Please enter your password:/
      end

      context "displays an error if" do
        it "email is blank" do
          $stdin.should_receive(:gets).and_return('')
          $stdout.should_not_receive(:print).with("Please enter your password: ")
          results = capture(:stderr) { login }
          results.should =~ /You must enter a value for that field./
        end

        it "password is blank" do
          $stdout.should_receive(:print).with("Please enter your email: ")
          $stdout.should_receive(:print).with("Please enter your password: ")
          $stdin.should_receive(:gets).and_return('foo@bar.com', '')
          results = capture(:stderr) { login }
          results.should =~ /You must enter a value for that field./
        end
      end
    end

    context "when credentials are provided" do
      let(:login) do
        VMC::Cli.start(["login", "--email", 'foo@bar.com', "--password", 'sekret'])
      end

      it "does not ask for email or password" do
       $stdin.should_not_receive(:gets)
       results = capture(:stdout) { login }
       results.should =~ /Attempting to login./
      end
    end
  end
end
