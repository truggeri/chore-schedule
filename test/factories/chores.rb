# == Schema Information
#
# Table name: chores
#
#  id             :bigint(8)        not null, primary key
#  description    :string           not null
#  frequency      :integer          not null
#  frequency_type :integer          default("days"), not null
#  last_performed :datetime
#  perform_next   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint(8)
#  family_id      :bigint(8)
#
# Indexes
#
#  index_chores_on_category_id   (category_id)
#  index_chores_on_family_id     (family_id)
#  index_chores_on_preform_next  (perform_next)
#

FactoryBot.define do
  sequence :skill do |n|
    "#{FFaker::Skill.specialty} #{n}"
  end

  factory :chore do

    description { generate(:skill) }
    family
    frequency      { Random.rand(1..4) }
    frequency_type { Chore.frequency_types.keys.sample }
    last_performed { FFaker::Time.between(1.month.ago, 1.minute.ago) }

    after(:create) do |chore|
      log = create(:chore_performance_log, chore: chore, family: chore.family, performed_at: chore.last_performed)
      chore.chore_performance_logs << log
    end

    trait :with_category do
      after(:build) do |chore|
        chore.category = create(:category)
      end
    end

    trait :never_done do
      last_performed { nil }

      after(:create) do |chore|
        chore.chore_performance_logs.each(&:delete)
      end
    end
  end
end
