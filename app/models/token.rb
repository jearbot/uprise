# == Schema Information
#
# Table name: tokens
#
#  id             :bigint           not null, primary key
#  expires_at     :datetime
#  expires_in     :string
#  granted_scopes :string
#  refresh_token  :string
#  token          :string
#  token_type     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
class Token < ApplicationRecord
  before_commit :set_expires_at
  belongs_to :user, optional: true

  private

  def set_expires_at
    self.expires_at = Time.zone.now + (expires_in.to_i.seconds - 60.seconds)
  end
end
