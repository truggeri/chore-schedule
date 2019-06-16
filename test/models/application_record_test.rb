require "test_helper"

class ApplicationRecordTest < ActiveSupport::TestCase
  def setup
    @chore  = create(:chore, :never_done)
    @family = @chore.family
  end

  test "#family scope in scope" do
    assert_equal(1, Chore.family(@family).count)
  end

  test "#family scope out of scope" do
    family = create(:family)
    assert_equal(0, Chore.family(family).count)
  end

  test "#family scope no family" do
    assert_equal(1, Chore.family(nil).count)
  end
end