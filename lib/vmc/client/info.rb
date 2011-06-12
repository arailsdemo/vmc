module VMC
  class Client
    module Info
      def info
        get(VMC::INFO_PATH)
      end
    end
  end
end
