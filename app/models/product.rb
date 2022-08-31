class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :product_carts
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
end
