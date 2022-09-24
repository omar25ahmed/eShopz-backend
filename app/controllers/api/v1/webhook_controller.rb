class Api::V1::WebhookController < ApplicationController
  skip_load_and_authorize_resource
  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:stripe][:webhook]
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts 'Signature error'
      p e
      return
    end

    # Handle the event
    case event.type
    when 'payment_intent.succeeded'
      session = event.data.object
      Product.create!(name: 'sessionlineitemsdataname', price: 1000, name_es: 'too long nameee',
                      description: 'aaaaaaaaaaaa', description_es: 'aaaaaaaaaa', stock: 1, brand: 'iphone')
    end

    render json: { message: 'success' }
  end
end
