FactoryBot.define do
  factory :managemant do
    budget { "1" }
    result { "1" }
    result_date { "2020-06-01" }
    user_id { "1" }
    association :user
  end
end
