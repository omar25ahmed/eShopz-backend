class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :created_at, :first_name, :last_name, :country, :phone, :image_url, :admin,
             :stripe_customer_id
end
