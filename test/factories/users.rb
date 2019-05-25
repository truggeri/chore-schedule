# == Schema Information
#
# Table name: users
#
#  id           :bigint(8)        not null, primary key
#  chores_total :integer          default(0), not null
#  chores_week  :integer          default(0), not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint(8)
#  family_id    :bigint(8)
#
# Indexes
#
#  index_users_on_family_id  (family_id)
#  index_users_on_name       (name)
#

FactoryBot.define do
  factory :user do
    account
    chores_total { Random.rand(0..5) }
    chores_week  { Random.rand(0..chores_total) }
    family
    name { FFaker::Name.html_safe_name }
  end
end
