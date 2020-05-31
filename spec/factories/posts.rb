FactoryBot.define do
  factory :post do
    content { "MyText" }
    field { "MyString" }
    title { "MyString" }
    user_id { "1" }
    association :user
  end
end
