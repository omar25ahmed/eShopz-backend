class Api::V1::ProductCartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @product_carts = current_user.product_carts
    render json: @product_carts, include: [:product]
  end

  def show
    @product_cart = ProductCart.find(params[:id])
    render json: @product_cart, include: %i[user product]
  end

  def create
    current_user.product_carts.new(product_cart_params)
    if current_user.save
      render json: current_user.product_carts.last, include: [:product]
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def update
    @product_cart = ProductCart.find(params[:id])
    if @product_cart.update(product_cart_params)
      render json: @product_cart, include: [:product]
    else
      render json: @product_cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product_cart = ProductCart.find(params[:id])
    @product_cart.destroy
    head :no_content
  end

  private

  def product_cart_params
    params.require(:product_cart).permit(:quantity, :user_id, :product_id)
  end
end
