FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { |n| "name#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" } 
    password "password"
    password_confirmation "password"

    trait :changed_password do
      password "changedpassword"
      password_confirmation "changedpassword"
    end
  end
end