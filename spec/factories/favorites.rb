FactoryBot.define do
  factory :favorite do
    user_id { "1" }
    post_id { "1" }
    association :post
    association :user
  end
end
