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

require "test_helper"

class ChorePerformanceLogTest < ActiveSupport::TestCase
  def setup
    @chore_log = create(:chore_performance_log)
  end

  test "has family" do
    @chore_log.family = nil
    assert(!@chore_log.valid?)
  end

  test "has chore" do
    @chore_log.chore = nil
    assert(!@chore_log.valid?)
  end

  test "performed_at" do
    @chore_log = create(:chore_performance_log, performed_at: nil)
    assert_in_delta(Time.now.utc, @chore_log.performed_at, 5.seconds)
  end
end
