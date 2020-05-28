FactoryBot.define do
  factory :post do
    content { "MyText" }
    field { "MyString" }
    title { "MyString" }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.png')) }
    user_id { "1" }
    association :user
  end
end
