class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # include Rails.application.routes.url_helpers
  after_create :create_stripe_customer
  has_many :shipping_addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :product_carts, dependent: :destroy
  has_many :products, through: :product_carts
  has_many :order_details, through: :orders
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { maximum: 50, minimum: 2 }

  def image_url
    image.url if image.attached?
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(email:)
    update(stripe_customer_id: customer.id)
  end
end
