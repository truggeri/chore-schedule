class StaticPagesController < ApplicationController
  before_action :authenticate_account!, only: [:dashboard]

  def index; end

  def dashboard
    overdue_chores =  Chore.overdue.by_user(current_account&.user).by_urgency
    due_soon_chores = Chore.almost_due.by_user(current_account&.user).by_urgency

    render("dashboard", locals: { overdue_chores: overdue_chores, due_soon_chores: due_soon_chores })
  end
end
