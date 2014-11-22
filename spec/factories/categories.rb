FactoryGirl.define do
  factory :category do
    sequence(:name, 100) { |n| "Category #{n}" }
  end
end
