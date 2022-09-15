class Api::V1::CheckoutController < ApplicationController
  skip_load_and_authorize_resource
  def create
    @session = Stripe::Checkout::Session.create({
                                                  payment_method_types: ['card'],
                                                  line_items: [{
                                                    price_data: {
                                                      currency: 'usd',
                                                      product_data: {
                                                        name: params[:product_name],
                                                        images: [params[:product_image]]
                                                      },
                                                      unit_amount: params[:product_price].to_i * 100
                                                    },
                                                    quantity: params[:product_quantity]
                                                  }],
                                                  mode: 'payment',
                                                  success_url: 'https://example.com/success',
                                                  cancel_url: 'https://example.com/cancel'
                                                })
    render json: @session.url, status: :ok
  end
end
