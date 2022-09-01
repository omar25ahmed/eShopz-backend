class Api::V1::ShippingAddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @shipping_addresses = current_user.shipping_addresses
    render json: @shipping_addresses, include: [:user]
  end

  def show
    @shipping_address = ShippingAddress.find(params[:id])
    render json: @shipping_address, include: [:user]
  end

  def create
    current_user.shipping_addresses.new(shipping_address_params)
    if current_user.save
      render json: current_user.shipping_addresses.last, include: [:user]
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      render json: @shipping_address
    else
      render json: @shipping_address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    head :no_content
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:address, :city, :state, :postal_code, :user_id, :phone, :country,
                                             :additional_notes)
  end
end
