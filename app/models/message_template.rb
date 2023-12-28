# == Schema Information
#
# Table name: message_templates
#
#  id         :bigint           not null, primary key
#  body       :string
#  cadence    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MessageTemplate < ApplicationRecord
end
