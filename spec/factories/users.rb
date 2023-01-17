FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.name }
    biography { Faker::FunnyName.name }
    password { "123456" }
    email { Faker::Internet.email }
  end
end
