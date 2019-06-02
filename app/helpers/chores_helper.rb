module ChoresHelper
  COLUMN_DISPLAY_NAMES = {
    description:  "Name",
    frequency:    "Frequency",
    perform_next: "Next Due"
  }.freeze

  def category_badge(chore)
    if chore.category.present?
      style = "background-color: \##{chore.category.color};" if chore.category.color.present?
      badge = content_tag(:span, chore.category.name, class: "badge badge-pill badge-secondary", style: style)
      link = link_to(badge, category_path(chore.category))
    end
    content_tag(:div, link, id: "category-badge")
  end

  def chore_edit_modal
    render(
      partial: "shared/generic_modal",
      locals: {
        action: "edit",
        form: render(partial: "/chores/form", locals: { given_action: "update", show_buttons: false }),
        form_action: "edit_chore_submit(#{@chore.id});",
        model: "chore",
        submit_icon: fa_icon("edit", "fas"),
      }
    )
  end

  def category_mini_badge(category)
    color = category&.color.presence || "f0f0f0"
    style = "background-color: \##{color}; margin-right: 8px; border: 1px solid \##{color}"
    content_tag(:div, " ", class: "badge", style: style)
  end

  def category_select(categories)
    return "" unless categories&.size&.positive?

    options = [nil, '-']
    categories.each { |c| options << c }
    select(:chore, :category_id, options)
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
    %i[description frequency perform_next].each do |column|
      output << header_with_sort(column)
    end
    safe_join(output, "\n")
  end

  def days_until_due(chore, stylize = true)
    days = chore.days_until_due
    return days if days.positive?
    return "Today" if days.zero?

    stylize == true ? content_tag(:span, "Overdue", class: "chore-overdue-text font-weight-bold") : days.abs
  end

  def history_columns(logs)
    return content_tag(:div, "This chore hasn't been performed yet", class: "col font-italic") if logs.blank?

    output = []
    logs.each do |log|
      name_tag = content_tag(:h6, safe_join([fa_icon("user"), log.user&.name], " "))
      output << content_tag(:div, name_tag, class: "col-5 text-left chore-padding-8 chore-border-ultralight")
      time_tag = content_tag(:span, log.performed_at.strftime("%a, %B %e %Y, %l %P"), class: "text-right")
      output << content_tag(:div, time_tag, class: "col-7 text-right chore-padding-8 chore-border-ultralight")
    end
    safe_join(output)
  end

  def last_performed_text(chore)
    chore&.last_performed&.strftime('%A, %B %e %Y') || "Not yet performed"
  end

  def header_with_sort(name, display = nil)
    display ||= COLUMN_DISPLAY_NAMES[name]
    query_order = :desc if @order == :asc
    link_to(display, chores_path(sort: name, order: query_order), class: "dropdown-item")
  end

  def text_until_next_due(chore)
    if (Time.now - chore.perform_next).abs < 1.day
      text = "Soon"
    else
      text = distance_of_time_in_words(Time.now, chore.perform_next)
      text << " overdue" if chore.perform_next.past?
    end
    text
  end
end
