FactoryGirl.define do
  factory :location do
    sequence(:name, 100) { |n| "Doggie Palace #{n}" }
    description "Great accommodations for your dog"
    address "455 N Rexford Dr"
    city "Beverly Hills"
    state "CA"
    postal_code "90210"
    url "fakedogpalace.org"
    public false
    flagged false
    latitude "34.0711181"
    longitude "-118.3997601"
  end
end
