class Api::V1::CheckoutController < ApplicationController
  skip_load_and_authorize_resource
  def create
    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id,
                                                  payment_method_types: ['card'],
                                                  line_items: [params[:cart].map {|product| {price: product[:price_id], quantity: product[:quantity]}}],
                                                  mode: 'payment',
                                                  success_url: 'https://example.com/success',
                                                  cancel_url: 'https://example.com/cancel'
                                                })
    render json: @session.url, status: :ok
  end
end
