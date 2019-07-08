require "test_helper"

class ChorePerformanceLogDecoratorTest < Draper::TestCase
  def setup
    @log       = create(:chore_performance_log)
    @decorator = @log.decorate
  end

  test "#performed_at when nil" do
    @log.created_at = nil
    assert_equal(@decorator.performed_at, "Not yet performed")
  end

  test "#performed_at when valid" do
    @log.created_at = Date.new(2019, 4, 21)
    assert_equal(@decorator.performed_at, "Sunday, April 21 2019")
  end
end