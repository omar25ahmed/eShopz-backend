class AddBrandToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :brand, :string
  end
end
