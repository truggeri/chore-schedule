require "test_helper"

class StaticPagesHelperTest < ActionView::TestCase
  include ApplicationHelper

  def setup; end

  test "#more_link no additional_text" do
    expected = "<div class='more-link'><a href='/foo'>More <i class='fa fa-angle-double-right'></i></a></div>"
    assert_dom_equal(expected, more_link("/foo"))
  end

  test "#more_link with additional_text" do
    expected = "<div class='more-link'><a href='/foobar'>More foo <i class='fa fa-angle-double-right'></i></a></div>"
    assert_dom_equal(expected, more_link("/foobar", "foo"))
  end
end
