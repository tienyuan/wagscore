FactoryGirl.define do
  factory :user do
    sequence(:username, 100) { |n| "username#{n}" }
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
    admin false
  end
end
