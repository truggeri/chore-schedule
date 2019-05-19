module ApplicationHelper
  def fa_icon(klass, fa_type = "fa")
    content_tag(:i, "", class: "#{fa_type} fa-#{klass}")
  end

  def family_display
    return "" if session[:family_name].blank?
    output_text = safe_join([fa_icon("users", "fas"), " #{session[:family_name]} Family"])
    content_tag(:span, output_text, class: "navbar-family-name")
  end

  def full_title(page_title = '')
    base_title = "Chore Schedule"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
