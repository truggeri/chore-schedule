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

require 'test_helper'

class ChorePerformanceLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
