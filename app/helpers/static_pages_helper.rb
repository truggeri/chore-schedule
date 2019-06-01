module StaticPagesHelper
  def more_link(link, additional_text = "")
    text = additional_text.present? ? "More #{additional_text}" : "More"
    link_text = safe_join([text, fa_icon("angle-double-right")], " ")
    content_tag(:div, link_to(link_text, link), class: "more-link")
  end
end
