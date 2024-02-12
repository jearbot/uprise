# == Schema Information
#
# Table name: message_templates
#
#  id         :bigint           not null, primary key
#  body       :string
#  cadence    :integer
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MessageTemplate < ApplicationRecord
  acts_as_paranoid
  
  validates :cadence, presence: true
  validates :body, presence: true
end
