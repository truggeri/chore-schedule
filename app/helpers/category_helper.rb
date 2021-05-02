module CategoryHelper
  COLUMN_CLASSES = "chore-padding-8 chore-border-ultralight".freeze

  def category_badge_with_count(category, display = " ")
    style = "background-color: \##{category.color};" if category.color.present?
    content_tag(:span, display, class: "label", style: style)
  end

  def category_summary(categories)
    return "No categories" if categories.empty?

    output = []
    header_cols = []
    header_cols << content_tag(:div, "", class: "four-fifth chore-padding-8 text-center")
    header_cols << content_tag(:div, "Count", class: "chore-padding-8 text-center")
    header_cols << content_tag(:div, "", class: "chore-padding-8 text-center")
    output << content_tag(:div, safe_join(header_cols), class: "flex")
    categories.each { |cat| output << category_summary_row(cat) }
    safe_join(output, "\n")
  end

  def category_summary_row(category)
    return content_tag(:div, "", class: "") if category.nil?

    cols = []
    cols << content_tag(:div,
                        safe_join([category_badge_with_count(category),
                                   link_to(category.name, category_path(category))], " "),
                        class: "#{COLUMN_CLASSES} four-fifth")
    cols << content_tag(:div, category.chore_count, class: "#{COLUMN_CLASSES} text-center")
    trash_button = content_tag(:label, class: "button pseudo", for: "remove-confirm-modal", data: { disable: true },
      onclick: "adjust_category_delete_path('#{category_path(category)}', '#{category.name}');") do
      fa_icon("trash")
    end
    cols << content_tag(:div, trash_button, class: "#{COLUMN_CLASSES} text-center")
    content_tag(:div, safe_join(cols), class: "flex")
  end

  def chore_summary_column(chore)
    cols = []
    cols << content_tag(:div, link_to(chore.description, chore_path(chore)), class: COLUMN_CLASSES)
    cols << content_tag(:div, chore.last_performed&.strftime("%a, %B %e"), class: COLUMN_CLASSES)
    cols << content_tag(:div, chore.perform_next&.strftime("%a, %B %e"), class: COLUMN_CLASSES)
    content_tag(:div, safe_join(cols), class: "flex")
  end

  def chore_summary_columns(chores)
    return "No chores in this category" if chores.empty?

    output = []
    header_cols = []
    header_cols << content_tag(:div, "", class: "chore-padding-8")
    header_cols << content_tag(:div, "Last Performed", class: "chore-padding-8")
    header_cols << content_tag(:div, "Due At", class: "chore-padding-8")
    output << content_tag(:div, safe_join(header_cols), class: "flex")
    chores.each { |chore| output << chore_summary_column(chore) }
    safe_join(output, "\n")
  end
end
