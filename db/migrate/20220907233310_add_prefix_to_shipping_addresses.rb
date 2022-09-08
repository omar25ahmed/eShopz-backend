class AddPrefixToShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_addresses, :prefix, :string
  end
end
