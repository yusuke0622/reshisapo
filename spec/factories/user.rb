FactoryBot.define do
    factory :user do
        name { 'Testname' }
        email { 'Faker::Internet.free_email' }
        password { 'aaBB1234' }
        password_confirmation { password }
    end
end