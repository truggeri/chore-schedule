class CategoryController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def show
    @category = Category.find_by(id: params[:id])
    @chores   = @category&.chores
  end

  def create
    @category = Category.new(permitted_params)
    if @category.save
      flash[:success] = "#{@category.name} created successfully"
    else
      flash[:error] = "Category could not be created"
    end
    redirect_to(category_index_path)
  end

  private

  def permitted_params
    params.require(:category).permit(:name, :color)
  end
end
