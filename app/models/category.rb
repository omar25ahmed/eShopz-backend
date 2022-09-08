class Category < ApplicationRecord
  has_and_belongs_to_many :products

  validates :name, :name_es, presence: true, length: { maximum: 200, minimum: 2 }
end
