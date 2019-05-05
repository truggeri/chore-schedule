module CategoryHelper
  COLUMN_CLASSES = "col chore-padding-8 chore-border-ultralight".freeze

  def category_badge_with_count(category, count)
    style = "background-color: \##{category.color};" if category.color.present?
    content_tag(:span, "#{count} chores", class: "badge badge-pill badge-secondary", style: style)
  end

  def category_color_badge(category)
    color = category.color.presence || "f0f0f0"
    style = "background-color: \##{color}; margin-right: 8px; border: 1px solid \##{color}"
    content_tag(:div, " ", class: "badge", style: style)
  end

  def chore_summary_column(chore)
    cols = []
    cols << content_tag(:div, link_to(chore.description, chore_path(chore)), class: COLUMN_CLASSES)
    cols << content_tag(:div, chore.last_performed&.strftime("%a, %B %e"), class: COLUMN_CLASSES)
    cols << content_tag(:div, chore.perform_next&.strftime("%a, %B %e"), class: COLUMN_CLASSES)
    content_tag(:div, safe_join(cols), class: "row")
  end

  def chore_summary_columns(chores)
    return "No chores in this category" if chores.empty?
    output = []
    header_cols = []
    header_cols << content_tag(:div, "", class: "col chore-padding-8")
    header_cols << content_tag(:div, "Last Performed", class: "col chore-padding-8")
    header_cols << content_tag(:div, "Due At", class: "col chore-padding-8")
    output << content_tag(:div, safe_join(header_cols), class: "row")
    chores.each { |chore| output << chore_summary_column(chore) }
    safe_join(output, "\n")
  end
end
