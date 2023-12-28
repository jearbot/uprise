class SmsMessage < ApplicationRecord
  enum delivery_status: { pending: 0, sent: 1, failed: 2 }
end
