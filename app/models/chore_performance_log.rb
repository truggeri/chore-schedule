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

class ChorePerformanceLog < ApplicationRecord
  belongs_to :chore
  belongs_to :family
  belongs_to :user, counter_cache: :chores_total

  validates :family, presence: true

  before_create -> { self.performed_at = Time.now.utc }
end
