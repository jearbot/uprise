FactoryBot.define do
  factory :message_template do
    name { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    cadence { 0 }
  end
end
