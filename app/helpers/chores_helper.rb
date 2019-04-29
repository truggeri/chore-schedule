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

  def chore_sort_by_name
    COLUMN_DISPLAY_NAMES[@sort]
  end

  def chore_sort_icon
    @order == :desc ? "fas fa-sort-alpha-up" : "fas fa-sort-alpha-down"
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
    stylize == true ? content_tag(:span, days.abs, class: "text-danger font-weight-bold") : days.abs
  end

  def history_columns(logs)
    if logs.present?
      output = []
      logs.each do |log|
        name_tag = content_tag(:h6, safe_join([content_tag(:i, "", class: "fa fa-user"), log.user&.name], " "))
        output << content_tag(:div, name_tag, class: "col-5 text-left chore-padding-8 chore-border-ultralight")
        time_tag = content_tag(:span, log.performed_at.strftime("%a, %B %e %Y, %l %P"), class: "text-right")
        output << content_tag(:div, time_tag, class: "col-7 text-right chore-padding-8 chore-border-ultralight")
      end
      safe_join(output)
    else
      content_tag(:div, "This chore hasn't been performed yet", class: "col font-italic")
    end
  end

  def last_performed_text(chore)
    if @chore.last_performed.present?
      safe_join(["Last performed on", "<br />".html_safe, "#{chore.last_performed.strftime('%A, %B %e %Y')}"])
    else
      "Not yet performed"
    end
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

  def perform_as_columns(users)
    output = []
    user_icon = content_tag(:i, "", class: "fa fa-user")
    users.each do |user|
      user_button = content_tag(:button, user_icon + " #{user.name}",
                                type: "button",
                                class: "btn btn-outline-success",
                                onclick: "perform_chore_now('#{perform_now_chore_path(@chore.id, user_id: user.id)}');")
      output << content_tag(:div, user_button, class: "col text-center")
    end
    safe_join(output, "")
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
