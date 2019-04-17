class ChoresController < ApplicationController
  def index
    @chores = Chore.all
  end

  def show
    @chore = Chore.find_by(id: params[:id])
    @logs = ChorePerformanceLog.where(chore: @chore).order(performed_at: :desc).limit(5)
  end

  def new
    @chore = Chore.new
  end

  def create
    @chore = Chore.new(permitted_params)
    if @chore.save
      flash[:success] = "Chore created successfully"
      redirect_to(@chore)
    else
      render "new"
    end
  end

  def destroy
    @chore = Chore.find_by(id: params[:id])
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
    @chore = Chore.find_by(id: params[:id])
    ajax_redirect_to(chores_path); return if @chore.blank?
    @chore.last_performed = Time.now.utc
    @chore.set_first_time
    if @chore.save
      ChorePerformanceLog.create(chore: @chore)
      flash[:success] = "Chore performed"
    else
      flash[:error] = "Chore could not be performed"
    end
    ajax_redirect_to(chore_path(@chore))
  end

  private

  def permitted_params
    frequency_type_to_sym(params[:chore][:frequency_type].to_i)
    params.require(:chore).permit(:description, :frequency, :frequency_type, :last_performed, :perform_next)
  end

  def frequency_type_to_sym(ft)
    Chore.frequency_types.each do |k, v|
      params[:chore][:frequency_type] = k if ft == v
    end
  end
end
