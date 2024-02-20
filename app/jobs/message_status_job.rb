class MessageStatusJob
  include Sidekiq::Worker

  def perform(member_scope, message)
    members = Member.active.public_send(member_scope)

    return if members.blank?

    members.each do |member|
      MessageSender.send_message(member.normalized_phone_number, message)
    end
  end
end