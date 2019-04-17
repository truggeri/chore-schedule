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

require 'test_helper'

class ChorePerformanceLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
