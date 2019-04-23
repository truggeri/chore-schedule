class StaticPagesController < ApplicationController
  def index; end

  def dashboard
    @chores = Chore.front_page
    @chore = Chore.new
    @categories = Category.front_page
  end
end
