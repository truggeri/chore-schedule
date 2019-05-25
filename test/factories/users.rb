FactoryBot.define do
  factory :user do
    chores_total { Random.rand(0..5) }
    chores_week  { Random.rand(0..chores_total) }
    family
    name { FFaker::Name.html_safe_name }
  end
end
