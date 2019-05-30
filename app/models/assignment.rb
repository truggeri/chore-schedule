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

class Assignment < ApplicationRecord
  belongs_to :chore
  belongs_to :user

  validates :chore, presence: true
  validates :times_performed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user, presence: true
end
