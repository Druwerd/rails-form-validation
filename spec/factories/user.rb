FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Password123!@#' }
    password_confirmation { 'Password123!@#' }

    trait :invalid_email do
      email { 'invalid_email' }
    end
  end
end
