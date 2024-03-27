module TgBot
  module Operations
    class ReactToMessage < BaseOperation
      def initialize(webhook)
        # будем оборачивать наше сообщение
        @message = Values::Message.new(webhook[:message])
      end

      def call
        # SendMessage.call(chat_id, hello_text)
        # return

        # если сообщение не приватное, не будем на него отвечать
        return unless message.private?

        # если цифры - ищем код
        return SendMessage.call(chat_id, info_text(@message.text.to_i)) if @message.text.to_i > 0

        # иначе ищем название
        case @message.text
        when "/start"
          SendMessage.call(chat_id, hello_text)
        # when '/lips'
          # SendVideo.call(chat_id, 'BAACAgIAAxkBAAIBB2Xhkbz_x1lLngJtZ4U6TrfsvxZeAALlQQAC_S4JS1xjvxnAXoI9NAQ')
        else
          SendMessage.call(chat_id, unknown_command_text)
        end
      end

      private

      attr_reader :message

      def chat_id
        message.chat.id
      end

      def hello_text
        <<~MESSAGE_TEXT
          Привет!
          Скинь код - получишь инфу
        MESSAGE_TEXT
      end

      def unknown_command_text
        <<~MESSAGE_TEXT
          не знаю такой команды.
          Скинь код - получишь инфу о нём.
        MESSAGE_TEXT
      end

      def info_text(product_id)
        product = Product.find_by(id: product_id)
        if product.nil?
          "#{product_id} - нет данных"
        else
          <<~MESSAGE_TEXT
          #{product_id}: #{product.name} #{product.art} #{product.razd}
          #{product.price}р
          MESSAGE_TEXT
        end
      end
    end
  end
end