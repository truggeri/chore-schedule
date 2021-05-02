module ChoresHelper
  COLUMN_DISPLAY_NAMES = {
    description:  "Name",
    frequency:    "Frequency",
    perform_next: "Next Due"
  }.freeze

  def category_badge(chore)
    if chore.category.present?
      style = "background-color: \##{chore.category.color};" if chore.category.color.present?
      badge = content_tag(:span, chore.category.name, class: "label", style: style)
      link = link_to(badge, category_path(chore.category))
    end
    content_tag(:div, link, id: "category-badge")
  end

  def chore_edit_modal
    render(
      "shared/generic_modal",
      action:      "edit",
      form:        render("/chores/form", action_path: chore_path(@chore)),
      form_action: "edit_chore_submit(#{@chore.id});",
      model:       "chore",
      submit_icon: fa_icon("edit", "fas")
    )
  end

  def category_mini_badge(category)
    color = category&.color.presence || "f0f0f0"
    style = "background-color: \##{color}; margin-right: 8px; border: 1px solid \##{color}"
    content_tag(:div, " ", class: "badge", style: style)
  end

  def category_select(categories, selected = nil)
    return "" unless categories&.size&.positive?

    options = [nil, '-']
    categories.each { |c| options << c }
    select(:chore, :category_id, options, selected: selected)
  end

  def chore_sort_by_name(sort)
    COLUMN_DISPLAY_NAMES[sort]
  end

  def chore_sort_icon(order)
    klass = order == :desc ? "sort-alpha-up" : "sort-alpha-down"
    fa_icon(klass, "fas")
  end

  def chore_sort_links
    output = []
    COLUMN_DISPLAY_NAMES.each_key do |column|
      output << header_with_sort(column)
    end
    safe_join(output, "\n")
  end

  def days_until_due_text(chore, stylize: true)
    days = chore.days_until_due
    return days if days.positive?
    return "Today" if days.zero?

    stylize == true ? content_tag(:span, "Overdue", class: "chore-overdue-text font-weight-bold") : days.abs
  end

  def history_columns(logs)
    return content_tag(:div, "This chore hasn't been performed yet", class: "full font-italic") if logs.blank?

    output = []
    logs.each do |log|
      name_tag = content_tag(:h6, safe_join([fa_icon("user"), log.user&.name], " "))
      output << content_tag(:div, name_tag, class: "half text-left chore-padding-8 chore-border-ultralight")
      time_tag = content_tag(:span, log.performed_at.strftime("%a, %B %e %Y, %l %P"), class: "text-right")
      output << content_tag(:div, time_tag, class: "half text-right chore-padding-8 chore-border-ultralight")
    end
    safe_join(output)
  end

  def header_with_sort(name, display = nil)
    display ||= COLUMN_DISPLAY_NAMES[name]
    query_order = :desc if @order == :asc
    link_to(display, chores_path(sort: name, order: query_order), class: "stack")
  end
end
