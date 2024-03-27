module TgBot
  module Operations
    class SendMovieRecommendation < BaseOperation
      def initialize(chat_id, director_name)
        @chat_id = chat_id
        @director = Director.find_by(name: director_name)
        @director_name = director_name
      end

      def call
        unless director
          return SendMessage.call(chat_id, no_director_message)
        end

        @movie = @director.movies.sample

        SendMessage.call(chat_id, message_text)
      end

      private

      attr_reader :chat_id, :director

      def no_director_message
        <<~MESSAGE_TEXT
          Режиссер с таким именем(#{@director_name}) не найден. По команде /start можно увидеть некоторых режиссеров из тех, что у нас есть.
        MESSAGE_TEXT
      end

      def message_text
        <<~MESSAGE_TEXT
          Сегодня вечером рекомендую посмотреть фильм: #{@movie.title} (#{@movie.year})
        MESSAGE_TEXT
      end
    end
  end
end