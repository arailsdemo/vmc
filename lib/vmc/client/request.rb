module VMC
  class Client
    module Request
      def get(path, options={})
        request(:get, path, options)
      end

      def post(path, options={})
        request(:post, path, options)
      end

      private

      def request(action, path, options)
        check_login_status if options[:require_auth]
        headers = auth_token ? { 'AUTHORIZATION' => auth_token } : {}
        headers.merge!(options[:headers]) if options[:headers]

        response = connection.send(action, path) do |request|
          request.body = options[:body] if options[:body]
          request.headers = headers unless headers.empty?
        end

        response.body
      end

      def check_login_status
        raise AuthError unless logged_in? || auth_token_valid?
      end
    end
  end
end
