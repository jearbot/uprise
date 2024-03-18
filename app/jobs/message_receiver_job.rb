class MessageReceiverJob
  include Sidekiq::Worker
  STOP_PHRASES = ["STOP", "STOPALL", "UNSUBSCRIBE", "CANCEL", "END", "QUIT"]
  START_PHRASES = ["START", "YES", "UNSTOP", "SUBSCRIBE", "RESUME"]
  BOOKING_PHRASES = ["YES", "NO", "MORE"]

  def perform(phone_number, body)
    member = Member.find_by(normalized_phone_number: phone_number)

    return unless member

    # TODO: Refactor this to allow this to receive a message from a member regarding their attendance

    if START_PHRASES.include?(body)
      member.resubscribe
      MessageSender.send_welcome_message(member.normalized_phone_number) if member.subscribed?
    elsif STOP_PHRASES.include?(body)
      member.unsubscribe
    elsif BOOKING_PHRASES.include?(body)
      case body
      when "YES"
        CalendarService.new.book_event(member, member.events.last)
      when "NO"
        CalendarService.new.cancel_event(member, member.events.last)
      when "MORE"
        next_event = CalendarService.new.list_events(member, start_time: Time.now, end_time: Time.now + 2.days)

      end
    end
  end
end
