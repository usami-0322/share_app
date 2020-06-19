FactoryBot.define do
  factory :user do
    name { "example" }
    employee_number { "123" }
    password { "password" }
    password_confirmation { "password" }
  end
end
