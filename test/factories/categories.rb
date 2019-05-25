FactoryBot.define do
  factory :category do
    chore_count { Random.rand(0..10) }
    color       { FFaker::Color.hex_code }
    family
    name { FFaker::Product.brand }

    trait :with_chore do
      after(:build) do |cat|
        create(:chore, category: cat)
      end
    end

    trait :with_chores do
      after(:build) do |cat|
        Random.rand(1..3).times do
          create(:chore, category: cat)
        end
      end
    end
  end
end
