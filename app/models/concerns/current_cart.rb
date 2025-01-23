# app/models/concerns/current_cart.rb
module CurrentCart
  extend ActiveSupport::Concern

  included do
    before_action :set_current_cart
  end

  private

  def set_current_cart
    if user_signed_in?
      @current_cart = current_user.cart || create_cart_for_user(current_user)
      # Transfer items from session cart to user cart if exists
      if session[:cart_id] && @current_cart.cart_items.empty?
        transfer_session_cart_to_user(session[:cart_id], @current_cart)
      end
      session[:cart_id] = nil
    elsif session[:cart_id]
      @current_cart = Cart.find_by(id: session[:cart_id]) || create_guest_cart
    else
      @current_cart = create_guest_cart
    end
    Rails.logger.debug "Current cart: #{@current_cart.inspect}"
  end

  def transfer_session_cart_to_user(session_cart_id, user_cart)
    session_cart = Cart.find_by(id: session_cart_id)
    return unless session_cart

    session_cart.cart_items.each do |item|
      user_cart.cart_items.create(
        product: item.product,
        quantity: item.quantity
      )
    end
    session_cart.destroy
  end

  def create_cart_for_user(user)
    cart = Cart.create(user: user)
    user.update(cart: cart)
    cart
  end

  def create_guest_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def current_cart
    @current_cart
  end
end
