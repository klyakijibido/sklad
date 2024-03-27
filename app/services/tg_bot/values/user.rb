module TgBot
  module Values
    class User
      attr_reader :id, :username

      def initialize(user_params)
        @id = user_params[:id]
        @username = user_params[:username]
      end
    end
  end
end