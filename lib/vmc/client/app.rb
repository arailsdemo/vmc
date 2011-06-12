module VMC
  class Client
    module App
      def app_info
        get("#{VMC::APPS_PATH}/#{app_name}", :require_auth => true)
      end
    end
  end
end
