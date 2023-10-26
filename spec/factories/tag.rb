FactoryBot.define do
    factory :tag do
        association :recipe, factory: :recipe
        tag_name { Faker::Lorem.characters(number:4) }
    end
end