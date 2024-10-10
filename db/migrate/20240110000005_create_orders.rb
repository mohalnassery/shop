class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price, precision: 8, scale: 2
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end