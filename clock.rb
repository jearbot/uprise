require 'clockwork'
require 'active_support/time' # Allow numeric durations (eg: 1.minutes)

module Clockwork
  # every(1.day, TruncateSmsMessagesJob, at: '12:00')
  every(1.hour, Rsvp::CalendarEventsJob, at: '**:00')
  every(1.hour, RefreshTokenJob, at: '**:00')
end
