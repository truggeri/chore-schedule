class UsersController < ApplicationController
  def index
    @users = User.family(current_account&.family)
  end

  def show
    @user = User.includes(:assignments)
                .family(current_account&.family)
                .find_by(id: params[:id])
                .decorate
    @logs = ChorePerformanceLog.includes(:chore)
                               .family(current_account&.family)
                               .where(user: @user)
                               .order(id: :desc)
                               .limit(5)
                               .decorate
  end
end
