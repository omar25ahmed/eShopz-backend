class Api::V1::CategoriesController < ApplicationController
  def index
    @categories = Category.all.includes([:products])
    render json: @categories, include: [:products]
  end

  def show
    @category = Category.find(params[:id])
    render json: @category, include: [:products]
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    head :no_content
  end

  private

  def category_params
    params.require(:category).permit(:name, :name_es)
  end
end
