# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Password123!@#' }
    password_confirmation { 'Password123!@#' }

    trait :invalid_email do
      email { 'invalid_email' }
    end

    # Add any other traits or additional attributes as needed
  end
end
