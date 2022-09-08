class RemoveProductsRefToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    remove_reference :order_details, :product, null: false, foreign_key: true
    add_reference :order_details, :product, null: true, foreign_key: true
  end
end
