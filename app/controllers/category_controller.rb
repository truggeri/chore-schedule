class CategoryController < ApplicationController
  before_action :authenticate_account!

  before_action :load_categories, only: %i[show]

  def index
    @categories = Category.family(current_account&.family).order(name: :asc)
    @category = Category.new
  end

  def show
    @category = Category.find_by(id: params[:id], family: current_account&.family)
    @chores   = @category&.chores
    @chore    = Chore.new(category: @category)
  end

  def create
    @category = Category.new(permitted_params)
    @category.family = current_account&.family
    if @category.save
      flash[:success] = "#{@category.name} created successfully"
    else
      flash[:error] = "Category could not be created"
    end
    redirect_to(category_index_path)
  end

  def destroy
    @chore = Category.find_by(id: params[:id], family: current_account&.family)
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
    color_param = params.dig(:category, :color)
    params[:category][:color] = params[:category][:color][1..] if color_param.present? && color_param[0] == "#"
    params.require(:category).permit(:name, :color)
  end
end
