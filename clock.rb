require 'clockwork'
require 'active_support/time' # Allow numeric durations (eg: 1.minutes)

module Clockwork
  # every(1.day, TruncateSmsMessagesJob, at: '12:00')
  # every(1.hour, RsvpJob, at: '**:00')
end
