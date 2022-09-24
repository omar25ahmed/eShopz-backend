class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :product_carts, dependent: :destroy
  has_many :users, through: :product_carts
  has_many :order_details, dependent: :nullify
  has_many :orders, through: :order_details
  has_many_attached :images
  after_create :create_stripe_product

  validates :name, :price, :description, :stock, :name_es, :description_es, :brand, presence: true
  validates :name, :name_es, length: { maximum: 200, minimum: 10 }
  validates :description, :description_es, length: { maximum: 4000, minimum: 10 }
  validates :price, numericality: { greater_than: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :brand, length: { maximum: 200, minimum: 2 }
  # validates :images, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  def create_stripe_product
    product = Stripe::Product.create(name:, description:,
                                     default_price_data: { currency: 'usd', unit_amount_decimal: (price * 100).to_i })
    update(stripe_product_id: product.id, stripe_price_id: product.default_price)
  end
end
