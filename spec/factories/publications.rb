FactoryBot.define do
  factory :publication do
    title { Faker::FunnyName.name }
    title_description { Faker::FunnyName.name }
    content { title { Faker::FunnyName.name } }
    image { "#{Faker::Internet.domain_name}.jpg" }

    association :category, factory: :category
  end
end
