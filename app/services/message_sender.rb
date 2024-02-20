module MessageSender
  require "twilio-ruby"

  ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
  AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

  class << self
    def client
      @client ||= Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    end

    def send_message(phone_number, body)
      begin
        return if phone_number.blank?
        recipient = Member.find_by(normalized_phone_number: phone_number)

        return if prevent_delivery?(recipient)
  
        send_welcome_message(phone_number) if recipient.sms_messages.empty?

        message = client.messages.create(
          from: ENV["TWILIO_FROM_NUMBER"],
          to: phone_number,
          body: body
        )
  
        create_message_record(message)
  
      rescue Twilio::REST::RestError
      end
    end

    def prevent_delivery?(recipient)
      recipient.nil? ||
        recipient.unsubscribed? ||
        recipient.archived?
    end

    def create_message_record(message)
      SmsMessage.create!(
        message_body: message.body,
        from_number: message.from,
        to_number: message.to,
        delivery_status: message.status,
        outbound: true,
        message_sid: message.sid,
        segment_count: message.num_segments
      )
    end
  
    def send_welcome_message(phone_number, force: false)
      client.messages.create(
        from: ENV["TWILIO_FROM_NUMBER"],
        to: phone_number,
        body: "You are receiving this message because you have been added to the Uprise Circus distribution list. Reply STOP to unsubscribe."
      )
    end

    def send_unsubscribe_message(phone_number, force: false)
      client.messages.create(
        from: ENV["TWILIO_FROM_NUMBER"],
        to: phone_number,
        body: "You have been unsubscribed from Uprise Circus. Reply START to resubscribe."
      )
    end
  end
end
