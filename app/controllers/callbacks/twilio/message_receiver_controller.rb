class Callbacks::Twilio::MessageReceiverController < ApplicationController
  ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']

  def create

  end

  def client
    @client ||= @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end
end
