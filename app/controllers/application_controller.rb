class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_family_name, if: -> { account_signed_in? }

  private

  def set_family_name
    return nil unless session[:family_name].blank? && current_account.present?

    session[:family_name] = current_account.family[:name]
  end

  def ajax_redirect_to(url)
    head(302, x_ajax_redirect_url: url)
  end

  def load_categories
    @categories = Category.family(current_account&.family).pluck(:name, :id)
  end
end
