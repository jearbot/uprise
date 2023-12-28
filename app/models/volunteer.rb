class Volunteer < ApplicationRecord
  after_update :normalize_phone_number if phone_number_changed?

  has_many :sms_messages

  validates :phone_number, presence: true, uniqueness: true

  private

  def normalize_phone_number
    self.update!(normalized_phone_number: PhonyRails.normalize_number(number, default_country_code: 'US'))
  end
end
