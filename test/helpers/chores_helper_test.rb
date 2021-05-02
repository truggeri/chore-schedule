require "test_helper"

class ChoresHelperTest < ActionView::TestCase
  include ApplicationHelper

  def setup
    @chore = create(:chore)
  end

  test "#category_badge with no category" do
    assert_dom_equal "<div id='category-badge'></div>", category_badge(@chore)
  end

  test "#category_badge with a category" do
    @chore = create(:chore, :with_category)
    expected = "<div id='category-badge'><a href='/category/#{@chore.category.id}'>\
<span class='label' style='background-color: ##{@chore.category.color};'>\
#{@chore.category.name}</span></a></div>"
    assert_dom_equal expected, category_badge(@chore)
  end

  test "#category_mini_badge" do
    category = create(:category)
    expected = "<div class='badge' style='background-color: ##{category.color}; margin-right: 8px; border: 1px solid \
##{category.color}'> </div>"
    assert_dom_equal expected, category_mini_badge(category)
  end

  test "#category_mini_badge without color" do
    category = create(:category, :without_color)
    expected = "<div class='badge' style='background-color: #f0f0f0; margin-right: 8px; border: 1px solid \
#f0f0f0'> </div>"
    assert_dom_equal expected, category_mini_badge(category)
  end

  test "#category_select" do
    categories = [create(:category), create(:category)]
    result = category_select(categories)
    expected = "<select name=\"chore[category_id]\" id=\"chore_category_id\"><option value=\"\">" \
               "</option>\n<option value=\"-\">-</option>"
    assert_includes result, expected
    categories.each do |cat|
      expected = "<option value=\"#{safe_join([cat])}\">#{safe_join([cat])}</option>"
      assert_includes result, expected
    end
  end

  test "#category_select when nil" do
    assert_equal "", category_select([nil, []].sample)
  end

  test "#chore_sort_icon desc" do
    assert_dom_equal "<i class='fas fa-sort-alpha-up'></i>", chore_sort_icon(:desc)
  end

  test "#chore_sort_icon asc" do
    assert_dom_equal "<i class='fas fa-sort-alpha-down'></i>", chore_sort_icon(:asc)
  end

  test "#chore_sort_icon random" do
    assert_dom_equal "<i class='fas fa-sort-alpha-down'></i>", chore_sort_icon(:foo)
  end

  test "#chore_sort_links" do
    expected = "<a class=\"stack\" href=\"/chores?sort=description\">Name</a>
<a class=\"stack\" href=\"/chores?sort=frequency\">Frequency</a>
<a class=\"stack\" href=\"/chores?sort=perform_next\">Next Due</a>"
    assert_dom_equal expected, chore_sort_links
  end

  test "#days_until_due_text future" do
    expected = @chore.days_until_due.zero? ? "Today" : @chore.days_until_due
    assert_equal(expected, days_until_due_text(@chore))
  end

  test "#days_until_due_text today" do
    @chore.perform_next = 15.minutes.from_now
    assert_equal "Today", days_until_due_text(@chore)
  end

  test "#days_until_due_text past" do
    @chore.perform_next = 10.days.ago
    assert_dom_equal "<span class=\"chore-overdue-text font-weight-bold\">Overdue</span>", days_until_due_text(@chore)
  end

  test "#days_until_due_text past, stylize=false" do
    @chore.perform_next = 10.days.ago
    assert_equal 10, days_until_due_text(@chore, stylize: false)
  end
end
