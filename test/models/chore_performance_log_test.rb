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
#  user_id      :bigint(8)
#

require 'test_helper'

class ChorePerformanceLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
