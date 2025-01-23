module Carts
  class CartItemsController < ApplicationController
    def update
      @cart_item = current_cart.cart_items.find(params[:id])
      if @cart_item.update(cart_item_params)
        redirect_to cart_path, notice: 'Quantity updated successfully'
      else
        redirect_to cart_path, alert: 'Failed to update quantity'
      end
    end

    def destroy
      @cart_item = current_cart.cart_items.find(params[:id])
      @cart_item.destroy
      redirect_to cart_path, notice: 'Item removed from cart'
    end

    private

    def cart_item_params
      params.require(:cart_item).permit(:quantity)
    end
  end
end
