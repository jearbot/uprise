class MessageReceiverJob
  include Sidekiq::Worker

  def perform(phone_number)
    member = Member.find_by(normalized_phone_number: phone_number)

    return unless member

    MessageSender.send_welcome_message(member.normalized_phone_number) if member.subscribed?
    MessageSender.send_unsubscribe_message(member.normalized_phone_number) if member.unsubscribed?
  end
end
