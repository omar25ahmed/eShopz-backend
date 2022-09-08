class ShippingAddress < ApplicationRecord
  belongs_to :user

  validates :address, :city, :country, :phone, presence: true
  validates :address,
            length: { maximum: 200, minimum: 10, too_long: 'must be less than 200 characters',
                      too_short: 'must be at least 10 characters' }
  validates :city, length: { maximum: 50, minimum: 2, message: 'City must be between 2 and 50 characters' }
  validates :phone, length: { maximum: 20, minimum: 8, message: 'must be between 8 and 20 characters' }
  validates :prefix, length: { maximum: 5, minimum: 2, message: 'must be between 2 and 5 characters' }
  validates :country, inclusion: { in: ISO3166::Country.all_translated, message: '%<value> is not a valid country' }
end
