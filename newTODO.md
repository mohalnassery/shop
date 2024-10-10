# Manual Tasks

1. Implement the view for the shopping cart:
   - Create a new file `app/views/carts/show.html.erb`
   - Add functionality to display cart items, total, and buttons for removing items and emptying the cart

2. Update the layout to include the cart icon:
   - Modify `app/views/layouts/application.html.erb`
   - Add a cart icon with the number of items in the cart
   - Ensure it updates dynamically when items are added or removed

3. Implement flash messages for cart actions:
   - Update the `CartsController` to set appropriate flash messages
   - Ensure these messages are displayed in the layout and disappear after a short time

4. Add "Add to Cart" functionality:
   - Update the `ProductsController` to handle adding items to the cart
   - Modify the product views to include an "Add to Cart" button

5. Implement user-specific product management:
   - Update the `ProductsController` to ensure only the creator can edit or delete their products
   - Modify the product views to show edit/delete options only for the product owner

6. Test and debug:
   - Thoroughly test all implemented features
   - Ensure proper error handling and edge cases are covered

7. (Optional) Implement the bonus features:
   - Add categories to products
   - Create an "Add to Cart" button on the product index page
   - Implement a payment method integration

8. Update the seeds file:
   - Modify `db/seeds.rb` to include sample data for all models, including the new `Cart` and `CartItem`

9. Review and update model associations:
   - Ensure all models (`User`, `Product`, `Cart`, `CartItem`, `Category`) have the correct associations defined

10. Update the README:
    - Provide clear instructions on how to set up and run the project
    - List all implemented features and any known issues