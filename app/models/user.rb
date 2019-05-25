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

class User < ApplicationRecord
  belongs_to :account
  belongs_to :family
  has_many   :chore_performance_log, dependent: :nullify

  validates :account, presence: true
  validates :family,  presence: true
  validates :name,    presence: true
end
