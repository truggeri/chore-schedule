module StaticPagesHelper
  def category_box(category, last_row: false)
    return nil if category.nil?
    name_link = link_to(category.name, category_path(category))
    header = content_tag(:h5, name_link, class: "category-header")
    count_box = content_tag(:div, category.chore_count, class: "category-count")
    content_tag(:div, safe_join([header, count_box]), class: "category-box")
  end

  def chore_box(chore = nil, last_row: false)
    return content_tag(:div, "", class: "chore-box") if chore.nil?
    contents = [content_tag(:h4, link_to(chore.description, chore_path(chore)))]
    contents << content_tag(:div, chore.last_performed_string, class: "last-done")
    top_row = content_tag(:div, safe_join(contents), class: "top-row")
    bottom_row_text = "Next due on #{chore&.perform_next_string}, #{days_until_due(chore, false)} days"
    bottom_row = content_tag(:div, bottom_row_text, class: "bottom-row")
    content_tag(:div, safe_join([top_row, bottom_row]), class: "chore-box #{'last-row' if last_row}")
  end
end
