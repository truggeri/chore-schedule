module CategoryHelper
  def category_color_badge(category)
    style = "background-color: \##{category.color}; margin-right: 8px;"
    content_tag(:div, " ", class: "badge", style: style) if category.color.present?
  end
end
