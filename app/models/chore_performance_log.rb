# == Schema Information
#
# Table name: chore_performance_logs
#
#  id           :integer          not null, primary key
#  notes        :text
#  performed_at :datetime         not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chore_id     :bigint           not null
#  user_id      :bigint
#

class ChorePerformanceLog < ApplicationRecord
  belongs_to  :chore
  belongs_to  :user, counter_cache: :chores_total

  before_create -> { self.performed_at = Time.now.utc }
end
