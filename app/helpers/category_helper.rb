module CategoryHelper
  def category_color_badge(category)
    color = category.color.presence || "f0f0f0"
    style = "background-color: \##{color}; margin-right: 8px; border: 1px solid \##{color}"
    content_tag(:div, " ", class: "badge", style: style)
  end
end
