class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.string :brand
      t.string :model
      t.string :condition
      t.string :finish
      t.string :image
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end