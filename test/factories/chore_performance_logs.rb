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
