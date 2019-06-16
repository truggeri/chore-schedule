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

  test "#perform_next" do
    @chore.perform_next = Date.new(2019, 4, 21)
    assert_equal(@decorator.perform_next, "Sun, April 21 2019")
  end
end
