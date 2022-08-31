class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :total_price
      t.string :status, default: 'pending'
      t.text :shipping_address

      t.timestamps
    end
  end
end
