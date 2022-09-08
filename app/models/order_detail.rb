class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, :price, presence: true, numericality: { greater_than: 0 }
end
