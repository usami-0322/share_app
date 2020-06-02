FactoryBot.define do
  factory :comment do
    content { "MyString" }
    association :post
    user { post.user }
  end
end
