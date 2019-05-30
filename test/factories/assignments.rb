# == Schema Information
#
# Table name: assignments
#
#  id              :bigint(8)        not null, primary key
#  times_performed :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  chore_id        :bigint(8)        not null
#  user_id         :bigint(8)        not null
#
# Indexes
#
#  index_assignments_on_chore_id  (chore_id)
#  index_assignments_on_user_id   (user_id)
#

FactoryBot.define do
  factory :assignment do
    chore
    times_performed { Random.rand(0..5) }
    user

    trait :never_done do
      times_performed { 0 }
    end

    trait :done_before do
      times_performed { Random.rand(1..5) }
    end
  end
end
