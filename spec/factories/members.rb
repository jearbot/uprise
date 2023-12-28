FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone }
    normalized_phone_number { "+1#{Faker::PhoneNumber.cell_phone}" }
    unsubscribed { false }

    factory :volunteer do
      member_type { 0 }
    end

    factory :student do
      member_type { 1 }
    end
  end
end