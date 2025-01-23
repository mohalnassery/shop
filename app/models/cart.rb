class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def add_product(product, quantity = 1)
    current_item = cart_items.find_by(product: product)

    if current_item
      current_item.quantity += quantity
      current_item.save
    else
      current_item = cart_items.create!(
        product: product,
        quantity: quantity
      )
    end

    current_item
  rescue ActiveRecord::RecordInvalid
    false
  end

  def remove_product(product)
    item = cart_items.find_by(product: product)
    if item
      if item.quantity > 1
        item.quantity -= 1
        item.save
      else
        item.destroy
      end
    end
  end

  def remove_item(cart_item)
    cart_items.destroy(cart_item)
  end

  def empty_cart
    cart_items.destroy_all
  end

  def total_items
    cart_items.sum(:quantity)
  end
end
