class StaticPagesController < ApplicationController
  before_action :authenticate_account!, only: [:dashboard]

  def index; end

  def dashboard
    @chores = Chore.front_page.family(current_account&.family)
    @chore = Chore.new
    @categories = Category.front_page.family(current_account&.family)
    @user_summary = Chore.joins(:assignments).overdue.where(assignments: { user: current_account&.user }).by_urgency
  end
end
