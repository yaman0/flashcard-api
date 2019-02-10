FactoryBot.define do
  factory :collection do
    title { Faker::StarWars.character }
    favorite false
  end
end
