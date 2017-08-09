FactoryGirl.define do
  factory :thing do
    sequence(:name) { |i| "Name#{i}"}
    description { Faker::Lorem.sentence(1).chomp('.') }
    notes { Faker::Lorem.sentence(1).chomp('.') }
  end
end
