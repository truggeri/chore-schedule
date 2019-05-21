class StaticPagesController < ApplicationController
  before_action :authenticate_account!, only: [:dashboard]

  def index; end

  def dashboard
    @chores = Chore.front_page.family(current_account&.family)
    @chore = Chore.new
    @categories = Category.front_page.family(current_account&.family)
  end
end
