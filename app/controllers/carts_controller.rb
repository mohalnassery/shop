class CartsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :add_item, :remove_item, :empty_cart, :update_quantity]

  def show
    @cart = current_cart
  end

  def add_item
    product = Product.find(params[:product_id])
    current_cart.add_item(product)
    flash[:notice] = "#{product.title} added to your cart."
    redirect_back(fallback_location: root_path)
  end

  def remove_item
    item = CartItem.find(params[:id])
    item.destroy
    flash[:notice] = "#{item.product.title} removed from your cart."
    redirect_to cart_path
  end

  def empty_cart
    current_cart.cart_items.destroy_all
    flash[:notice] = "Your cart has been emptied."
    redirect_to cart_path
  end

  def update_quantity
    item = current_cart.cart_items.find(params[:item_id])
    new_quantity = params[:cart_item][:quantity].to_i

    if new_quantity > 0
      item.update(quantity: new_quantity)
      flash[:notice] = 'Quantity updated successfully.'
    else
      item.destroy
      flash[:notice] = 'Item removed from cart.'
    end

    redirect_to cart_path
  end
end