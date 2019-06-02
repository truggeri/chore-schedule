# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  chore_count :integer          default(0), not null
#  color       :string(6)
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  family_id   :bigint(8)
#
# Indexes
#
#  index_categories_on_family_id  (family_id)
#  index_categories_on_name       (name)
#

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

    trait :without_color do
      after(:create) do |cat|
        cat.update(color: nil)
      end
    end
  end
end
