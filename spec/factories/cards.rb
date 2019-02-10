FactoryBot.define do
  factory :card do
    front { Faker::Lorem.word }
    back { Faker::Lorem.word }
    collection_id { nil }
  end
end
