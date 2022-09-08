class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # include Rails.application.routes.url_helpers
  has_many :shipping_addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :product_carts, dependent: :destroy
  has_many :products, through: :product_carts
  has_many :order_details, through: :orders
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def image_url
    image.url if image.attached?
  end
end
