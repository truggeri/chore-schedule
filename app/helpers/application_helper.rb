module ApplicationHelper
  BASE_TITLE = "Chore Schedule".freeze

  def fa_icon(klass, fa_type = "fa")
    content_tag(:i, "", class: "#{fa_type} fa-#{klass}")
  end

  def family_display
    return "" if session[:family_name].blank?

    output_text = safe_join([fa_icon("users", "fas"), " #{session[:family_name]} Family"])
    link_to(output_text, "#", class: "nav-link")
  end

  def full_title(page_title = '')
    page_title.present? ? "#{page_title} | #{BASE_TITLE}" : BASE_TITLE
  end

  def user_display(user)
    return "" if user.blank?

    output_text = safe_join([fa_icon("user", "fas"), " #{user.name}"])
    link_to(output_text, user_path(user), class: "nav-link")
  end
end
