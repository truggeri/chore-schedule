class ChoresController < ApplicationController
  def index
    @chores = Chore.all
  end

  def show
    @chore = Chore.find_by(id: params[:id])
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
    redirect_to(chores_path)
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
