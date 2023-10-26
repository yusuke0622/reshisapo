FactoryBot.define do
    factory :ingredient do
        association :recipe, factory: :recipe
        ingredient_name { Faker::Lorem.characters(number:5) }
        quantity { Faker::Lorem.characters(number:5) }
    end
end