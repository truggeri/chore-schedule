require "test_helper"

class CategoryHelperTest < ActionView::TestCase
  include ApplicationHelper

  def setup; end

  test "#chore_summary_column" do
    chore = create(:chore)
    css_classes = "col chore-padding-8 chore-border-ultralight"
    cols = ["<div class='#{css_classes}'>#{link_to(chore.description, chore_path(chore))}</div>"]
    cols << "<div class='#{css_classes}'>#{chore.last_performed&.strftime('%a, %B %e')}</div>"
    cols << "<div class='#{css_classes}'>#{chore.perform_next&.strftime('%a, %B %e')}</div>"
    expected = "<div class='row'>#{cols.join}</div>"
    assert_dom_equal(expected, chore_summary_column(chore))
  end

  test "@chore_summary_columns when empty" do
    assert_equal("No chores in this category", chore_summary_columns(Chore.none))
  end

  test "@chore_summary_columns" do
    chore = create(:chore)
    assert_match("<div class=\"row\">", chore_summary_columns([chore]))
    assert_match("a href=\"\/chores\/#{chore.id}\"", chore_summary_columns([chore]))
  end
end
