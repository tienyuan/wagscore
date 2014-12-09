FactoryGirl.define do
  factory :location do
    sequence(:name, 100) { |n| "Doggie Palace #{n}" }
    sequence(:description, 100) { |n| "Doggie Palace #{n} has great accommodations for your dog" }
    address '455 N Rexford Dr'
    city 'Beverly Hills'
    state 'CA'
    zipcode '90210'
    url 'fakedogpalace.org'
    public false
    flagged false
    latitude '34.0711181'
    longitude '-118.3997601'
    categories { [create(:category)] }
  end
end
