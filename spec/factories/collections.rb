FactoryBot.define do
  factory :collection do
    title { Faker::StarWars.character }
    favorite false
    created_by { Faker::Number.number(10) }
  end
end
