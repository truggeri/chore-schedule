class ApplicationController < ActionController::Base
  private

  def ajax_redirect_to(url)
    head(302, x_ajax_redirect_url: url)
  end
end
