class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @categories = Category.all.sort_asc
    authorize @categories
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      flash[:error] = 'Category submission failed. Please try again.'
      render :new
    end
  end

  def update
    authorize @category
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category was successfully updated.'
    else
      flash[:error] = 'Category edit failed. Please try again.'
      render :edit
    end
  end

  def destroy
    authorize @category

    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully deleted.'
  end

  private
  
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
