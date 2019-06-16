require "test_helper"

class ChoreDecoratorTest < Draper::TestCase
  def setup
    @chore     = create(:chore)
    @decorator = @chore.decorate
  end

  test "#last_performed when nil" do
    @chore.last_performed = nil
    assert_equal(@decorator.last_performed, "never")
  end

  test "#last_performed when valid" do
    @chore.last_performed = Date.new(2019, 4, 21)
    assert_equal(@decorator.last_performed, "Sun, April 21 2019")
  end

  test "#last_performed_long when nil" do
    @chore.last_performed = nil
    assert_equal(@decorator.last_performed_long, "Not yet performed")
  end

  test "#last_performed_long when valid" do
    @chore.last_performed = Date.new(2019, 4, 21)
    assert_equal(@decorator.last_performed_long, "Sunday, April 21 2019")
  end

  test "#perform_next" do
    @chore.perform_next = Date.new(2019, 4, 21)
    assert_equal(@decorator.perform_next, "Sun, April 21 2019")
  end

  test "#perform_next_summary when <1 day" do
    @chore.perform_next = 1.hour.from_now
    assert_equal(@decorator.perform_next_summary, "Soon")
  end

  test "#perform_next_summary when >1 day" do
    @chore.perform_next = 2.days.from_now
    assert_equal(@decorator.perform_next_summary, "2 days")
  end

  test "#perform_next_summary when overdue" do
    @chore.perform_next = 2.days.ago
    assert_equal(@decorator.perform_next_summary, "2 days overdue")
  end
end
