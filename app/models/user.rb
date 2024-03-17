# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  deleted_at              :datetime
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  failed_attempts         :integer          default(0), not null
#  locked_at               :datetime
#  name                    :string
#  normalized_phone_number :string
#  phone_number            :string
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  PASSWORD_REGEX = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{8,}$/
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable

  after_create :normalize_email
  after_create :normalize_phone_number, :normalize_email

  after_update :normalize_email, if: :email_changed?
  before_save :normalize_phone_number, if: :phone_number_changed?

  validate :check_password_complexity, on: [:create, :update]

  has_many :tokens

  private

  def normalize_email
    self.email = email.downcase
  end

  def normalize_phone_number
    self.normalized_phone_number = PhonyRails.normalize_number(phone_number, default_country_code: 'US')
  end

  def check_password_complexity
    return if password.blank? || password =~ PASSWORD_REGEX

    errors.add(:password, 'must be at least 8 characters long, contain one upper case letter, one number, and one special character.')
    raise ActiveRecord::RecordInvalid.new(self)
  end
end
