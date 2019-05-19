class ApplicationController < ActionController::Base
  before_action :set_family_name, if: -> { account_signed_in? }

  private

  def set_family_name
    session[:family_name] = current_account&.family[:name] if session[:family_name].blank?
  end

  def ajax_redirect_to(url)
    head(302, x_ajax_redirect_url: url)
  end
end
