# == Schema Information
#
# Table name: chores
#
#  id             :bigint(8)        not null, primary key
#  description    :string           not null
#  frequency      :integer          not null
#  frequency_type :integer          default("days"), not null
#  last_performed :datetime
#  perform_next   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint(8)
#  family_id      :bigint(8)
#
# Indexes
#
#  index_chores_on_category_id   (category_id)
#  index_chores_on_family_id     (family_id)
#  index_chores_on_preform_next  (perform_next)
#

require "test_helper"

class ChoreTest < ActiveSupport::TestCase
  def setup
    @chore = create(:chore, :never_done)
  end

  # NOTE - good candidate for Timecop
  test "first time due" do
    assert_in_delta(Time.now.utc + eval("#{@chore.frequency}.#{@chore.frequency_type}"), @chore.perform_next, 5.seconds)
  end

  test "description not nil" do
    @chore.description = [nil, ""].sample
    assert(!@chore.valid?)
  end

  test "description length 100" do
    @chore.description = FFaker::Lorem.characters(101)
    assert(!@chore.valid?)
  end

  test "frequency > 0" do
    @chore.frequency = 0
    assert(!@chore.valid?)
  end

  test "has family" do
    @chore.family = nil
    assert(!@chore.valid?)
  end
end
