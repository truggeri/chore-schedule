FactoryBot.define do
  factory :chore do
    description { FFaker::Skill.specialty }
    family
    frequency      { Random.rand(1..4) }
    frequency_type { Chore.frequency_types.keys.sample }
    last_performed { FFaker::Time.between(1.month.ago, 1.minute.ago) }

    trait :with_category do
      after(:build) do |chore|
        chore.category = create(:category)
      end
    end

    trait :never_done do
      last_performed { nil }
    end
  end
end
