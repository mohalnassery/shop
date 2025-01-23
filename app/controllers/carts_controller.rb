# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  include CurrentCart

  before_action :set_current_cart
  
  def show
    @cart = @current_cart
    if @cart.nil?
      flash[:alert] = "Unable to find your cart."
      redirect_to root_path
    end
  end

  def add_item
    product = Product.find(params[:product_id])
    @current_cart.add_product(product)
    flash[:notice] = "#{product.title} was added to your cart."
    redirect_back(fallback_location: root_path)
  end

  def remove_item
    item = @current_cart.cart_items.find(params[:id])
    product_title = item.product.title
    item.destroy
    flash[:notice] = "#{product_title} was removed from your cart."
    redirect_to cart_path
  end

  def empty
    @current_cart.cart_items.destroy_all
    flash[:notice] = "Your cart has been emptied."
    redirect_to cart_path
  end

  def update_quantity
    item = @current_cart.cart_items.find(params[:item_id])
    new_quantity = params[:cart_item][:quantity].to_i
    
    if new_quantity > 0
      item.update(quantity: new_quantity)
      flash[:notice] = 'Cart updated successfully.'
    else
      product_title = item.product.title
      item.destroy
      flash[:notice] = "#{product_title} was removed from your cart."
    end
    
    redirect_to cart_path
  end

  def checkout
    @cart = current_cart
    redirect_to success_cart_path(@cart)
  end

  def success
    @cart = current_cart
    @order_number = "ORD-#{Time.current.to_i}"
    @order_date = Time.current
  end

  private

  def cart_params
    params.require(:cart).permit(cart_items_attributes: [:id, :quantity, :_destroy])
  end
end
