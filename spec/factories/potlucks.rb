FactoryGirl.define do
  factory :potluck do
    start_time 1.hour.from_now
    end_time 2.hours.from_now
  end
end
