# == Schema Information
#
# Table name: members
#
#  id                      :bigint           not null, primary key
#  archived                :boolean          default(FALSE)
#  deleted_at              :datetime
#  email                   :string
#  member_type             :integer
#  name                    :string
#  normalized_phone_number :string
#  phone_number            :string
#  unsubscribed            :boolean          default(FALSE)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_members_on_email                    (email) UNIQUE
#  index_members_on_member_type              (member_type)
#  index_members_on_normalized_phone_number  (normalized_phone_number) UNIQUE
#
class Member < ApplicationRecord
  acts_as_paranoid

  enum member_type: { volunteer: 0, student: 1 }

  validates :phone_number, presence: true, uniqueness: true
  validates :normalized_phone_number, uniqueness: true, unless: :new_record?
  validates :email, uniqueness: true, allow_blank: true

  scope :active, -> { where(archived: false) }
  scope :inactive, -> { where.not(archived: true) }

  scope :volunteers, -> { where(member_type: 'volunteer') }
  scope :students, -> { where(member_type: 'student') }
  scope :unsubscribed, -> { where(unsubscribed: true) }
  scope :subscribed, -> { where(unsubscribed: false) }

  before_save :normalize_phone_number, if: :phone_number_changed?
  before_save :normalize_email, if: :email_changed?
  after_create :normalize_phone_number, :normalize_email

  has_many :sms_messages, foreign_key: :to_number, primary_key: :normalized_phone_number

  def subscribed?
    !unsubscribed?
  end

  def unsubscribe
    update!(unsubscribed: true)
  end

  def resubscribe
    update!(unsubscribed: false)
  end

  private

  def normalize_phone_number
    self.normalized_phone_number = PhonyRails.normalize_number(phone_number, default_country_code: 'US')
  end

  def normalize_email
    self.email = email.downcase
  end
end
