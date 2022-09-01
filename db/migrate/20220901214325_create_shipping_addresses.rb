class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :postal_code
      t.text :address
      t.integer :phone
      t.text :additional_notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
