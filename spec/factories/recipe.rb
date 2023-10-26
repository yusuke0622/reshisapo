FactoryBot.define do
    factory :recipe do
        recipe_name { Faker::Lorem.characters(number:10) }
        introduction { Faker::Lorem.characters(number:20) } 
        category_id { Faker::Number.between(to: 1) }
        serving { Faker::Number.between(to: 3)}
        
        factory :recipe_with_tag do
            after(:create) do | recipe |
                create(:tag, recipe: recipe)
            end
        end
        
        factory :recipe_with_ingredient do
            after(:create) do |recipe|
                create(:ingredient, recipe: recipe)
            end
        end
        
        factory :recipe_with_step do
            after(:create) do |recipe|
                create(:step, recipe: recipe)
            end
        end
        
        association :user
    end
end