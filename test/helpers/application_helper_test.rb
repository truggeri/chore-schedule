require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper
  include Devise::Test::IntegrationHelpers

  def setup; end

  test "#fa_icon" do
    expected = "<i class='fa fa-bar'></i>"
    assert_dom_equal(expected, fa_icon("bar"))
  end

  test "#fa_icon with fas" do
    expected = "<i class='funky fa-bar'></i>"
    assert_dom_equal(expected, fa_icon("bar", "funky"))
  end

  test "#family_display when blank" do
    assert_equal("", family_display)
  end

  test "#family_display" do
    expected = "<a class=\"nav-link\" href=\"#\">#{fa_icon('users', 'fas')} Robinson Family</a>"
    session[:family_name] = "Robinson"
    assert_dom_equal(expected, family_display)
  end

  test "#full_title when blank" do
    assert_equal("Chore Schedule", full_title)
  end

  test "#full_title" do
    assert_equal("FooBar | Chore Schedule", full_title("FooBar"))
  end

  test "#user_display blank" do
    assert_equal("", user_display(nil))
  end

  test "#user_display" do
    user = create(:user)
    expected = "<a class=\"nav-link\" href=\"/users/#{user.id}\">#{fa_icon('user', 'fas')} #{user.name}</a>"
    assert_dom_equal(expected, user_display(user))
  end
end
