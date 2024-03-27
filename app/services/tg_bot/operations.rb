module TgBot
  module Operations
    class BaseOperation
      def self.call(*args)
        new(*args).call
      end

      def call
        raise NotImplementedError
      end
    end
  end
end