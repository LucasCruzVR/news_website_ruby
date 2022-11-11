class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update]
  def index
    @categories = Category.all
  end

  def show; end

  def create
    @category = Category.new(category_params)
    if @category.save
      render :show, status: :created
    else
      render json: @category.errors.messages, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
