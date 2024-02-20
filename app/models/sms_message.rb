# == Schema Information
#
# Table name: sms_messages
#
#  id              :bigint           not null, primary key
#  delivery_status :integer
#  from_number     :string
#  message_body    :string
#  message_sid     :string
#  outbound        :boolean
#  segment_count   :integer
#  to_number       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_sms_messages_on_message_sid  (message_sid) UNIQUE
#
class SmsMessage < ApplicationRecord
  enum delivery_status: { queued: 0, pending: 1, sent: 2, delivered: 3, undelivered: 4, failed: 5, received: 6 }
end
