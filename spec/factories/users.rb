FactoryGirl.define do
  factory :user do
    first_name "Jammie"
    last_name "Lannister"
    sequence(:email) { |n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"
    organization {create(:organization)}
  end

  factory :admin, parent: :user do
    admin true
  end
end
