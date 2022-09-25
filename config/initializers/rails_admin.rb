RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  config.model User do
    list do
      fields :id, :email, :first_name, :last_name, :admin, :created_at, :updated_at, :stripe_customer_id
      fields :shipping_addresses, :orders, :product_carts, :products, :order_details do
        eager_load true
      end
    end
    edit do
      fields :email, :first_name, :last_name, :admin, :password, :password_confirmation, :stripe_customer_id
      fields :shipping_addresses, :orders, :product_carts, :products, :order_details do
        eager_load true
      end
    end
  end

  config.model Product do
    list do
      fields :id, :name, :description, :price, :stock, :brand, :created_at, :updated_at
      fields :order_details, :product_carts, :categories do
        eager_load true
      end
    end
    edit do
      fields :id, :name, :description, :price, :stock, :brand, :created_at, :updated_at
      fields :order_details, :product_carts, :categories do
        eager_load true
      end
    end
  end

  config.model Category do
    list do
      fields :id, :name, :created_at, :updated_at
      fields :products do
        eager_load true
      end
    end
    edit do
      fields :name
      fields :products do
        eager_load true
      end
    end
  end

  config.model Order do
    list do
      fields :id, :user, :total_price, :created_at, :updated_at
      fields :order_details do
        eager_load true
      end
    end
    edit do
      fields :user, :total_price
      fields :order_details do
        eager_load true
      end
    end
  end

  config.model OrderDetail do
    list do
      fields :id, :order, :product, :quantity, :created_at, :updated_at
    end
    edit do
      fields :order, :product, :quantity
    end
  end

  config.model ShippingAddress do
    list do
      fields :id, :user, :address, :city, :state, :postal_code, :created_at, :updated_at
    end
    edit do
      fields :user, :address, :city, :state, :postal_code
    end
  end

  config.model ProductCart do
    list do
      fields :id, :user, :product, :quantity, :created_at, :updated_at
    end
    edit do
      fields :user, :product, :quantity
    end
  end

  ## == Devise ==
  config.authenticate_with do
    authenticate_or_request_with_http_basic('Login required') do |email, password|
       user = User.find_for_database_authentication(:email => email)
      if user && user.valid_for_authentication? { user.valid_password?(password) && user.admin? }
        sign_in :admin, user 
      end 
    end
  end


  # == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  # config.authenticate_with do
  #   # this is a rails controller helper
  #   authenticate_or_request_with_http_basic('Login required') do |username, password|
  
  #     # Here we're checking for username & password provided with basic auth
  #     resource = User.find_by(email: username)
  
  #     # we're using devise helpers to verify password and sign in the user 
  #     if resource.valid_password?(password)
  #       sign_in :admin, resource
  #     end
  #   end
  # end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
