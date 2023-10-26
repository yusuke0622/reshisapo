FactoryBot.define do
    factory :step do
        association :recipe, factory: :recipe
        explanation { Faker::Lorem.characters(number:10) }
    end
end