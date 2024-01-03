FactoryBot.define do
  factory :outbound_message, class: 'SmsMessage' do
    from_number { "+1#{Faker::PhoneNumber.area_code }" }
    to_number { "+1#{Faker::PhoneNumber.cell_phone }" }
    outbound { true }
    delivery_status { 2 }
    segment_count { 1 }
    message_body { Faker::Lorem.paragraph }
  end

  factory :inbound_message, class: 'SmsMessage'  do
    from_number { "+1#{Faker::PhoneNumber.cell_phone }" }
    to_number { "+1#{Faker::PhoneNumber.cell_phone }" }
    outbound { false }
    delivery_status { 2 }
    segment_count { 1 }
    message_body { Faker::Lorem.paragraph }
  end
end
