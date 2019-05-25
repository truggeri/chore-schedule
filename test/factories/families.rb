FactoryBot.define do
  factory :family do
    active { true }
    name   { FFaker::Name.html_safe_last_name }
  end
end
