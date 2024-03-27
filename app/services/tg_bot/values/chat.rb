module TgBot
  module Values
    class Chat
      attr_reader :id, :type

      def initialize(user_params)
        @id = user_params[:id]
        @type = user_params[:type]
      end

      def private?
        type == 'private'
      end
    end
  end
end