class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :name_es
      t.text :description_es

      t.timestamps
    end
  end
end
