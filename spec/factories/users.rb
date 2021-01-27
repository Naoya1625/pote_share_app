FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { |n| "name#{n}"}
    sequence(:email) { |n| "tester#{n}@example.com" } 
    password "password"
    password_confirmation "password"

  end
end
