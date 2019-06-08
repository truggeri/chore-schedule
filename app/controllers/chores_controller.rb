class ChoresController < ApplicationController
  before_action :authenticate_account!
  before_action :load_categories, only: %i[index show]

  def index
    @sort = determine_sort(params[:sort].presence)
    @order = determine_order(params[:order].presence)
    @chores = Chore.family(current_account&.family).order(@sort => @order)
    @chore = Chore.new
  end

  def show
    @chore = Chore.includes(:category, :assignments).find_by(id: params[:id], family: current_account&.family)
    @logs = ChorePerformanceLog.includes(:user)
                               .where(chore: @chore)
                               .family(current_account&.family)
                               .order(performed_at: :desc).limit(5)
    @users = User.family(current_account&.family).order(:id)
  end

  def create
    @chore = Chore.new(permitted_params)
    @chore.family = current_account&.family
    if @chore.save
      flash[:success] = "Chore created successfully"
      redirect_to(@chore)
    else
      flash[:error] = "Chore could not be created"
      redirect_to(chores_path)
    end
  end

  def edit
    @chore = Chore.includes(:category).find_by(id: params[:id], family: current_account&.family)
    @categories = Category.family(current_account&.family).pluck(:name, :id)
  end

  def update
    @chore = Chore.includes(:category).find_by(id: params[:id], family: current_account&.family)
    if @chore&.update_attributes(permitted_params)
      flash[:success] = "Chore '#{@chore.description}' has been updated"
      redirect_to(@chore)
    else
      flash[:error] = "Chore update as unsuccessful"
      redirect_to(chores_path)
    end
  end

  def destroy
    @chore = Chore.find_by(id: params[:id], family: current_account&.family)
    if @chore&.delete
      flash[:success] = "Chore successfully removed"
    else
      flash[:error] = "Chore could not be removed"
    end
    respond_to do |format|
      format.js   { ajax_redirect_to(chores_path) }
      format.html { redirect_to(chores_path) }
    end
  end

  def perform_now
    respond_to :js
    @chore = Chore.find_by(id: params[:id], family: current_account&.family)
    ajax_redirect_to(chores_path); return if @chore.blank?

    @chore.last_performed = Time.now.utc
    @chore.set_first_time
    if @chore.save
      ChorePerformanceLog.create(chore: @chore,
                                 user: User.find_by(id: params[:user_id]),
                                 family: current_account&.family)
      flash[:success] = "Chore performed"
    else
      flash[:error] = "Chore could not be performed"
    end
    ajax_redirect_to(chore_path(@chore))
  end

  def assign
    respond_to :js
    @chore = Chore.find_by(id: params[:id], family: current_account&.family)
    ajax_redirect_to(chores_path); return if @chore.blank?

    @assignment = Assignment.create(chore: @chore,
                                    user:  User.find_by(id: params[:user_id]))
    if @assignment.persisted?
      flash[:success] = "Chore assigned"
    else
      flash[:error] = "Chore could not be assigned"
    end
    ajax_redirect_to(chore_path(@chore))
  end

  private

  def determine_sort(param)
    return :perform_next unless param&.to_sym.in?(%i[description frequency perform_next])
    param.to_sym
  end

  def determine_order(param)
    param == "desc" ? :desc : :asc
  end

  def permitted_params
    frequency_type_to_sym(params[:chore][:frequency_type].to_i)
    adjust_category_id(params[:chore][:category_id])
    params.require(:chore).permit(:category_id, :description,
                                  :frequency, :frequency_type, :last_performed, :perform_next)
  end

  def adjust_category_id(param)
    if param == "-" || !param.to_i.positive?
      params[:chore][:category_id] = nil
      return false
    end
    category = Category.find_by(id: param.to_i, family: current_account&.family)
    params[:chore][:category_id] = if category&.valid?
                                     param.to_i
                                   else
                                     nil
                                   end
  end

  def frequency_type_to_sym(ft)
    Chore.frequency_types.each do |k, v|
      params[:chore][:frequency_type] = k if ft == v
    end
  end
end
