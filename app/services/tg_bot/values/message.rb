module TgBot
  module Values
    class Message
      attr_reader :message_id, :sender, :chat, :text

      delegate :private?, to: :chat

      def initialize(message_params)
        @message_id = message_params[:message_id]
        @sender = Values::User.new(message_params[:from])
        @chat = Values::Chat.new(message_params[:chat])
        @text = message_params[:text]
      end
    end
  end
end