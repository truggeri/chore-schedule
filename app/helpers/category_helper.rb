module CategoryHelper
  COLUMN_CLASSES = "col chore-padding-8 chore-border-ultralight".freeze

  def category_badge_with_count(category, display = " ")
    style = "background-color: \##{category.color};" if category.color.present?
    content_tag(:span, display, class: "badge badge-pill badge-secondary", style: style)
  end

  def category_summary(categories)
    return "No categories" if categories.empty?

    output = []
    header_cols = []
    header_cols << content_tag(:div, "", class: "col chore-padding-8  text-center")
    header_cols << content_tag(:div, "Chore Count", class: "col chore-padding-8 col-3 col-md-2 text-center")
    header_cols << content_tag(:div, "Remove", class: "col chore-padding-8 col-3 col-md-1 text-center")
    output << content_tag(:div, safe_join(header_cols), class: "row")
    categories.each { |cat| output << category_summary_row(cat) }
    safe_join(output, "\n")
  end

  def category_summary_row(category)
    return content_tag(:div, "", class: "") if category.nil?

    cols = []
    cols << content_tag(:div,
                        safe_join([category_badge_with_count(category),
                                   link_to(category.name, category_path(category))], " "),
                        class: COLUMN_CLASSES)
    cols << content_tag(:div, category.chore_count, class: "#{COLUMN_CLASSES} col-3 col-md-2 text-center")
    trash_button = <<~END_OF_BUTTON
      <button type="button" class="btn delete-button" data-toggle="modal" data-target="#removeConfirmModal"
      onclick="adjust_category_delete_path('#{category_path(category)}', '#{category.name}');">
      #{fa_icon('trash')}
      </button>
    END_OF_BUTTON
    cols << content_tag(:div, trash_button.html_safe, class: "#{COLUMN_CLASSES} col-md-1 col-3 text-center")
    content_tag(:div, safe_join(cols), class: "row")
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
