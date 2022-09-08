class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  validates :total_price, presence: true, numericality: { greater_or_equal_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending paid shipped cancelled] }
  validates :shipping_address, presence: true
end
