module VMC
  class Cli

    desc "login", "login to Cloud Foundry"
    method_option :email, :type => :string, :desc => 'Your email'
    method_option :password, :type => :string, :desc => 'Your password'

    def login
      email = options[:email] || get_option(:email)
      password = options[:password] || get_option(:password)
      say "Attempting to login."

      client = VMC::Client.new
      token = client.login(email, password)
      say "Login successful."

      config = VMC::Cli::Config.new
      config.update(:tokens, token)
    end

    protected

    def get_option(option)
      value = ask("Please enter your #{option}:")
      raise Thor::Error, "You must enter a value for that field." if value.empty?
      value
    end
  end
end
