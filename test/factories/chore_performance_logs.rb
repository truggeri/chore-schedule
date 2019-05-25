# == Schema Information
#
# Table name: chore_performance_logs
#
#  id           :bigint(8)        not null, primary key
#  notes        :text
#  performed_at :datetime         not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chore_id     :bigint(8)        not null
#  family_id    :bigint(8)
#  user_id      :bigint(8)
#
# Indexes
#
#  index_chore_performance_logs_on_family_id  (family_id)
#

FactoryBot.define do
  factory :chore_performance_log do
    chore
    family
    notes        { FFaker::Lorem.paragraph }
    performed_at { FFaker::Time.between(2.months.ago, 1.minute.ago) }
    user

    after(:create) do |log|
      chore = log.chore
      if chore.last_performed.present? && chore.last_performed < log.performed_at
        chore.update(last_performed: log.performed_at)
      end
    end
  end
end
