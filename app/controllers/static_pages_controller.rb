class StaticPagesController < ApplicationController
  before_action :authenticate_account!, only: [:dashboard]

  def index; end

  def dashboard
    @chores = Chore.front_page
    @chore = Chore.new
    @categories = Category.front_page
  end
end
