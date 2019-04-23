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

  def category_mini_badge(category)
    color = category&.color.presence || "f0f0f0"
    style = "background-color: \##{color}; margin-right: 8px; border: 1px solid \##{color}"
    content_tag(:div, " ", class: "badge", style: style)
  end

  def category_mini_link(category)
    badge = category_mini_badge(category)
    if category.present?
      link_to(badge, category_path(category))
    else
      badge
    end
  end

  def category_select(categories)
    return "" if categories.nil? || categories.size.zero?
    options = [nil, '-']
    categories.each { |c| options << c }
    select(:chore, :category_id, options)
  end

  def chore_box(chore = nil, last_row: false)
    return content_tag(:div, "", class: "chore-box") if chore.nil?
    contents = [content_tag(:h4, chore.description)]
    contents << content_tag(:div, chore.last_performed_string, class: "last-done")
    top_row = content_tag(:div, safe_join(contents), class: "top-row")
    bottom_row_text = "Next due on #{chore&.perform_next_string}, #{days_until_due(chore, false)} days"
    bottom_row = content_tag(:div, bottom_row_text, class: "bottom-row")
    content_tag(:div, safe_join([top_row, bottom_row]), class: "chore-box #{'last-row' if last_row}")
  end

  def days_until_due(chore, stylize = true)
    days = chore.days_until_due
    return days if days.positive?
    return "Today" if days.zero?
    stylize == true ? content_tag(:span, days.abs, class: "text-danger font-weight-bold") : days.abs
  end

  def perform_as_buttons(users)
    output = []
    user_icon = content_tag(:i, "", class: "fa fa-user")
    users.each do |user|
      output << content_tag(:button, user_icon + " #{user.name}",
                            type: "button",
                            class: "btn btn-success",
                            onclick: "perform_chore_now('#{perform_now_chore_path(@chore.id, user_id: user.id)}');")
    end
    safe_join(output, "   ")
  end

  # TODO-20190421 This method works, but is not very clean
  def header_with_sort(name, display = nil)
    display ||= COLUMN_DISPLAY_NAMES[name]
    output = []
    if name == @sort
      query_order = :desc if @order == :asc
      order_class = @order == :desc ? "fa-sort-up" : "fa-sort-down"
      output << content_tag(:i, "", class: "fas #{order_class}")
    end
    output.prepend(link_to(display, chores_path(sort: name, order: query_order)))
    safe_join(output, " ")
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
