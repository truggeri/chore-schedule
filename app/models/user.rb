# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  chores_total :integer          default(0), not null
#  chores_week  :integer          default(0), not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name)
#

class User < ApplicationRecord
  has_many :chore_performance_log, dependent: :nullify

  validates :name, presence: true
end
