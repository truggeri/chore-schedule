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

require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  def setup
    @assignment = create(:assignment)
  end

  test "times_performed cannot be nil" do
    @assignment.times_performed = nil
    assert(!@assignment.valid?)
  end

  test "times_performed cannot be negative" do
    @assignment.times_performed = -1
    assert(!@assignment.valid?)
  end

  test "times_performed can be zero" do
    @assignment.times_performed = 0
    assert(@assignment.valid?)
  end

  test "chore presence" do
    @assignment.chore = nil
    assert(!@assignment.valid?)
  end

  test "user presence" do
    @assignment.user = nil
    assert(!@assignment.valid?)
  end
end
