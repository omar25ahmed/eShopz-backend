class AddUsersToProductCarts < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_carts, :user, null: false, foreign_key: true
  end
end
