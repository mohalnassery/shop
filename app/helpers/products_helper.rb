module ProductsHelper
  def product_author(product)
    user = product.user
    user.name if user.present?
  end

  def product_price(product)
    number_to_currency(product.price)
  end

  def product_condition(product)
    content_tag(:span, product.condition, class: "badge badge-#{condition_class(product.condition)}")
  end

  def display_seller_name(product)
    product.user.name
  end

  def user_is_seller?(user, product)
    user && user == product.user
  end

  private

  def condition_class(condition)
    case condition
    when 'New'
      'success'
    when 'Excellent', 'Mint'
      'info'
    when 'Used', 'Fair'
      'warning'
    when 'Poor'
      'danger'
    else
      'secondary'
    end
  end
end
