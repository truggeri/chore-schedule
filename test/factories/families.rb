# == Schema Information
#
# Table name: families
#
#  id         :bigint(8)        not null, primary key
#  active     :boolean          default(TRUE), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  sequence :family_name do |n|
    "#{FFaker::Name.html_safe_last_name} #{n}"
  end
  factory :family do
    active { true }
    name   { generate(:family_name) }
  end
end
