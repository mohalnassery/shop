class Users::SessionsController < Devise::SessionsController
  include CurrentCart

  def destroy
    old_cart = @current_cart
    super do |resource|
      old_cart.destroy if old_cart && !old_cart.user_id
    end
  end
end
