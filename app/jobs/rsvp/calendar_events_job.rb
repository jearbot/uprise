class Rsvp::CalendarEventsJob
  include Sidekiq::Worker

  def perform
    items = CalendarService.new.list_events

    if items.present?
      items.each do |item|
        if item.summary == "Volunteer"
          # send a text to volunteers
        elsif item.summary == "Student"
          # send a text to students
        end
      end
    end
  end
end