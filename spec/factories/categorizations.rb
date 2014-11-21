FactoryGirl.define do
  factory :categorization do
    category { create(:category) }
    location { create(:location) }
  end
end
