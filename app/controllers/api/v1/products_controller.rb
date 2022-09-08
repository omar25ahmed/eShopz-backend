class Api::V1::ProductsController < ApplicationController
  def index
    @products = Product.all.includes([:categories])
    render json: @products, include: [:categories]
  end

  def show
    @product = Product.find(params[:id])
    render json: @product, include: [:categories]
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product
    else
      render json: @product.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :name_es, :description_es, :brand)
  end
end
