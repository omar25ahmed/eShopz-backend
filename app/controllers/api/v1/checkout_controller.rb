class Api::V1::CheckoutController < ApplicationController
  def create
    @session = Stripe::Checkout::Session.create({
                                                  payment_method_types: ['card'],
                                                  line_items: [{
                                                    name: 'T-shirt',
                                                    amount: 500,
                                                    currency: 'usd',
                                                    quantity: 1
                                                  }],
                                                  mood: 'payment',
                                                  success_url: 'https://example.com/success',
                                                  cancel_url: 'https://example.com/cancel'
                                                })
    respond_to do |format|
      format.js
    end
  end
end
