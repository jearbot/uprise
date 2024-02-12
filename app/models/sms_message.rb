# == Schema Information
#
# Table name: sms_messages
#
#  id              :bigint           not null, primary key
#  delivery_status :integer
#  from_number     :string
#  message_body    :string
#  outbound        :boolean
#  segment_count   :integer
#  to_number       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class SmsMessage < ApplicationRecord
  enum delivery_status: { pending: 0, sent: 1, delivered: 2, undelivered: 3, failed: 4 }

  # TODO: truncate the table after a certain number of days or records

end
