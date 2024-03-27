module TgBot
  BOT_TOKEN = ENV.fetch("TELEGRAM_BOT_TOKEN").freeze
  private_constant :BOT_TOKEN
  API_URL = "#{ENV.fetch("TELEGRAM_API_URL")}/bot#{BOT_TOKEN}".freeze
  private_constant :API_URL
end
