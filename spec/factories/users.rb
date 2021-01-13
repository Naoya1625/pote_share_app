FactoryBot.define do
  factory :user, aliases: [:owner] do

    name "Naoya"
    sequence(:email) { |n| "tester#{n}@example.com" } 
    password "password"
    password_confirmation "password"

  end
end