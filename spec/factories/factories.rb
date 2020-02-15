FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@example.com" }
    password { "test@example.com" }
  end

  factory :post do
    title { "Title Post" }
    body { "Body of post" }
    user
  end

  factory :comment do
    body { "Body of comment" }
    user
    post
  end
end