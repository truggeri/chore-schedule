class CategoryController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
    @chores   = @category&.chores
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(permitted_params)
    if @category.save
      flash[:success] = "#{@category.name} created successfully"
      redirect_to(@category)
    else
      render "new"
    end
  end

  private

  def permitted_params
    params.require(:category).permit(:name, :color)
  end
end
