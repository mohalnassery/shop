document.addEventListener('turbolinks:load', () => {
  const flashMessages = document.querySelectorAll('.flash');
  flashMessages.forEach(message => {
    setTimeout(() => {
      message.style.transition = 'opacity 0.5s ease';
      message.style.opacity = '0';
      setTimeout(() => {
        message.remove();
      }, 500);
    }, 3000);
  });

  // Add event listeners for add to cart buttons
  const addToCartButtons = document.querySelectorAll('.add-to-cart-button');
  addToCartButtons.forEach(button => {
    button.addEventListener('click', (event) => {
      event.preventDefault();
      const productId = button.dataset.productId;
      const quantity = 1; // You can modify this to allow custom quantities

      fetch(`/products/${productId}/add_to_cart`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ quantity: quantity })
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          updateCartItemCount(data.cart_item_count);
          // Show a success message
          const flashMessage = document.createElement('div');
          flashMessage.className = 'flash notice';
          flashMessage.textContent = 'Item added to cart successfully';
          document.body.appendChild(flashMessage);
          setTimeout(() => {
            flashMessage.style.opacity = '0';
            setTimeout(() => flashMessage.remove(), 500);
          }, 3000);
        } else {
          // Show an error message
          console.error('Failed to add item to cart');
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
    });
  });
});

function updateCartItemCount(count) {
  const cartItemCount = document.getElementById('cart-item-count');
  if (cartItemCount) {
    cartItemCount.textContent = count;
  }
}

import 'bootstrap'
import '../stylesheets/application'