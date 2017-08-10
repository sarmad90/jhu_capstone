FactoryGirl.define do
  factory :thing do
    sequence(:name) { |i| "Name#{i}"}
    description { Faker::Lorem.sentence(1).chomp('.') }
    notes { Faker::Lorem.sentence(1).chomp('.') }

    trait :with_image do
      transient do
        image_count 1
      end
      after(:build) do |thing, props|
        thing.thing_images << build_list(:thing_image, props.image_count, thing: thing)
      end
    end
  end
end
