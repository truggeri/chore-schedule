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

  def destroy
    @chore = Category.find_by(id: params[:id])
    if @chore&.delete
      flash[:success] = "Category successfully removed"
    else
      flash[:error] = "Category could not be removed"
    end
    respond_to do |format|
      format.js   { ajax_redirect_to(category_index_path) }
      format.html { redirect_to(category_index_path) }
    end
  end

  private

  def permitted_params
    params[:category][:color] = params[:category][:color][1..] if params[:category][:color][0] == "#"
    params.require(:category).permit(:name, :color)
  end
end
