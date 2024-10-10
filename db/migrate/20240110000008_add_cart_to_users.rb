class AddCartToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :cart, null: true, foreign_key: true
  end
end