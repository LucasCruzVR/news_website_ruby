class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]
  def index
    @categories = Category.order(name: :asc)
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
    if @category.update(category_params)
      render :show, status: :ok
    else
      render json: @category.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      head :ok
    else
      render json: @category.errors.messages, status: :unprocessable_entity
    end
  end

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
