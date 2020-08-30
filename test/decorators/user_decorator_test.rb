require "test_helper"

class UserDecoratorTest < Draper::TestCase
  def setup
    @user      = create(:user)
    @decorator = @user.decorate
  end

  test "#created_at when nil" do
    @user.created_at = nil
    assert_equal(@decorator.created_at, "-")
  end

  test "#created_at when valid" do
    @user.created_at = Date.new(2019, 4, 21)
    assert_equal(@decorator.created_at, "April 21 2019")
  end
end
