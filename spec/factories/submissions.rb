FactoryGirl.define do
  factory :submission do
    ip_address '0.0.0.0'
    email 'test@email.com'
    location { create(:location) }
  end
end
