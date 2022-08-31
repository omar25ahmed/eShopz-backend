class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :stock
      t.string :name_es
      t.text :description_es

      t.timestamps
    end
  end
end
