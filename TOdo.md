# Shop Project Detailed Todo List

## User Authentication

1. Implement `registrations_controller.rb` in `app/controllers/`:
   - [ ] Create the file `app/controllers/registrations_controller.rb`
   - [ ] Make the controller inherit from `Devise::RegistrationsController`
   - [ ] Define `sign_up_params` method:
     - [ ] Include `:name`, `:email`, `:password`, and `:password_confirmation` parameters
   - [ ] Define `account_update_params` method:
     - [ ] Include `:name`, `:email`, `:password`, `:password_confirmation`, and `:current_password` parameters
   - [ ] In `config/routes.rb`:
     - [ ] Update Devise configuration to use the custom registrations controller

2. Update user model and views:
   - [ ] In `app/models/user.rb`:
     - [ ] Add `validates :name, presence: true` to ensure name is required
   - [ ] In `app/views/devise/registrations/new.html.erb`:
     - [ ] Add a field for name using `f.input :name`
   - [ ] In `app/views/devise/registrations/edit.html.erb`:
     - [ ] Add a field for name using `f.input :name`

3. Test user authentication:
   - [ ] Start the Rails server
   - [ ] Test user registration:
     - [ ] Navigate to the registration page
     - [ ] Fill out the form with valid data (including name)
     - [ ] Submit the form and verify successful registration
   - [ ] Test user login:
     - [ ] Navigate to the login page
     - [ ] Enter valid credentials
     - [ ] Verify successful login
   - [ ] Test account update:
     - [ ] Navigate to the account edit page
     - [ ] Update user information (including name)
     - [ ] Verify changes are saved correctly

## Product Ads

1. Update `app/helpers/products_helper.rb`:
   - [ ] Implement `display_seller_name(product)` method:
     - [ ] Return the name of the user who created the product
   - [ ] Implement `user_is_seller?(user, product)` method:
     - [ ] Check if the given user is the creator of the product

2. Update product views:
   - [ ] In `app/views/products/index.html.erb`:
     - [ ] Add a line to display the seller's name for each product using `display_seller_name` helper
   - [ ] In `app/views/products/show.html.erb`:
     - [ ] Add a line to display the seller's name using `display_seller_name` helper
   - [ ] In both files:
     - [ ] Wrap edit and delete buttons in a conditional using `user_is_seller?` helper

3. Update `app/controllers/products_controller.rb`:
   - [ ] Implement `check_ownership` method:
     - [ ] Find the product by id
     - [ ] Check if the current user is the seller
     - [ ] Redirect with an error message if not the seller
   - [ ] Add `before_action :check_ownership, only: [:edit, :update, :destroy]`

4. Test product management:
   - [ ] Create a new user account
   - [ ] Create a product with this account
   - [ ] Verify that edit and delete buttons are visible for this product
   - [ ] Create another user account
   - [ ] Verify that edit and delete buttons are not visible for the product created by the first user
   - [ ] Attempt to access edit URL directly and verify redirect

## Shopping Cart

1. Create Cart model:
   - [ ] Run `rails generate model Cart user:references`
   - [ ] Open the generated migration file and review it
   - [ ] Run `rails db:migrate`
   - [ ] In `app/models/cart.rb`, add `has_many :cart_items` association
   - [ ] In `app/models/user.rb`, add `has_one :cart` association

2. Create CartItem model:
   - [ ] Run `rails generate model CartItem cart:references product:references quantity:integer`
   - [ ] Open the generated migration file and review it
   - [ ] Run `rails db:migrate`
   - [ ] In `app/models/cart_item.rb`, add associations for cart and product
   - [ ] In `app/models/product.rb`, add `has_many :cart_items` association

3. Implement cart functionality:
   - [ ] Create `app/controllers/carts_controller.rb`:
     - [ ] Implement `show` action to display cart contents
     - [ ] Implement `add_item` action to add a product to the cart
     - [ ] Implement `remove_item` action to remove a product from the cart
     - [ ] Implement `empty_cart` action to remove all items from the cart
   - [ ] Update `app/controllers/products_controller.rb`:
     - [ ] Implement `add_to_cart` action to add a product to the current user's cart

4. Create cart views:
   - [ ] Create `app/views/carts/show.html.erb`:
     - [ ] Iterate through cart items and display product details
     - [ ] Calculate and display total sum of all products
     - [ ] Add an "Empty Cart" button that calls the `empty_cart` action
     - [ ] Add individual "Remove" buttons for each item

5. Implement flash messages:
   - [ ] In `app/controllers/carts_controller.rb`:
     - [ ] Add flash messages for successful add, remove, and empty actions
   - [ ] In `app/controllers/products_controller.rb`:
     - [ ] Add flash message for successful add to cart action
   - [ ] In `app/views/layouts/application.html.erb`:
     - [ ] Add a section to display flash messages
   - [ ] In `app/javascript/packs/application.js`:
     - [ ] Add JavaScript to fade out flash messages after a few seconds

6. Add cart icon to layout:
   - [ ] Create `app/views/shared/_cart_icon.html.erb`:
     - [ ] Add an icon or text to represent the cart
     - [ ] Display the number of items in the cart
   - [ ] In `app/views/layouts/application.html.erb`:
     - [ ] Render the cart icon partial in the navigation bar
   - [ ] Use JavaScript to update the cart icon:
     - [ ] Create a function to update the cart item count
     - [ ] Call this function after adding/removing items from the cart

## Current Cart Concern

1. Create `app/models/concerns/current_cart.rb`:
   - [ ] Define `CurrentCart` module
   - [ ] Implement `set_current_cart` method:
     - [ ] Find or create a cart for the current user
     - [ ] For guest users, store cart ID in session
   - [ ] Implement `current_cart` method:
     - [ ] Return the cart set by `set_current_cart`

2. Integrate current_cart concern:
   - [ ] In `app/controllers/application_controller.rb`:
     - [ ] Include the `CurrentCart` concern
     - [ ] Add `before_action :set_current_cart`
   - [ ] Update `carts_controller.rb`:
     - [ ] Use `current_cart` instead of finding the cart by user
   - [ ] Update `products_controller.rb`:
     - [ ] Use `current_cart` in the `add_to_cart` action

3. Test cart functionality:
   - [ ] Test as a guest user:
     - [ ] Add items to cart
     - [ ] Verify cart persists across page refreshes
   - [ ] Test as a logged-in user:
     - [ ] Add items to cart
     - [ ] Log out and log back in
     - [ ] Verify cart items are still present
   - [ ] Test cart merging:
     - [ ] Add items to cart as a guest
     - [ ] Log in with an existing account
     - [ ] Verify guest cart items are merged with user's existing cart

## Additional Features and Enhancements

1. Implement product categories:
   - [ ] Run `rails generate model Category name:string`
   - [ ] Review and run the migration
   - [ ] Update `app/models/product.rb`:
     - [ ] Add `belongs_to :category` association
   - [ ] Update `app/models/category.rb`:
     - [ ] Add `has_many :products` association
   - [ ] Update product form in `app/views/products/_form.html.erb`:
     - [ ] Add a dropdown to select category
   - [ ] Update `app/controllers/products_controller.rb`:
     - [ ] Add category to strong parameters
   - [ ] Add category filter to product index page

2. Enhance product details:
   - [ ] Update `db/migrate/[timestamp]_create_products.rb`:
     - [ ] Add columns for brand, color, condition, etc.
   - [ ] Run `rails db:migrate`
   - [ ] Update `app/views/products/_form.html.erb`:
     - [ ] Add fields for new product attributes
   - [ ] Update `app/views/products/show.html.erb`:
     - [ ] Display new product attributes
   - [ ] Update `app/controllers/products_controller.rb`:
     - [ ] Add new attributes to strong parameters

3. Implement "Add to Cart" without opening ad:
   - [ ] Update `app/views/products/index.html.erb`:
     - [ ] Add "Add to Cart" button for each product
   - [ ] In `app/javascript/packs/application.js`:
     - [ ] Implement AJAX function to add item to cart
     - [ ] Update cart icon after successful addition

4. Improve cart item management:
   - [ ] Update `app/views/carts/show.html.erb`:
     - [ ] Add quantity input field for each item
     - [ ] Add "Update" button to change quantity
   - [ ] Update `carts_controller.rb`:
     - [ ] Implement action to update item quantity
     - [ ] Implement action to remove single item when quantity reaches 0

5. Custom design and layout:
   - [ ] Customize `app/views/layouts/application.html.erb`:
     - [ ] Improve overall structure and navigation
   - [ ] Create and update stylesheets:
     - [ ] Create custom styles for products, cart, and other pages
   - [ ] Ensure responsive design:
     - [ ] Test and adjust layout for various screen sizes

6. Basic payment integration:
   - [ ] Choose a payment gateway (e.g., Stripe)
   - [ ] Add necessary gems to Gemfile
   - [ ] Generate necessary models (e.g., Order, Payment)
   - [ ] Implement payment flow:
     - [ ] Create checkout page
     - [ ] Integrate payment gateway API
     - [ ] Handle successful and failed payments
   - [ ] Update cart to initiate checkout process

## Testing and Refinement

1. Write and run tests:
   - [ ] In `test/models/`:
     - [ ] Write unit tests for User, Product, Cart, CartItem models
   - [ ] In `test/controllers/`:
     - [ ] Write integration tests for main user flows (registration, product management, cart operations)
   - [ ] In `test/system/`:
     - [ ] Write system tests for critical functionality (e.g., complete purchase flow)

2. Perform manual testing:
   - [ ] Create test scenarios document
   - [ ] Test all user roles (guest, registered user, admin)
   - [ ] Test all CRUD operations for products
   - [ ] Test cart functionality thoroughly
   - [ ] Test edge cases (e.g., adding out-of-stock items, invalid inputs)

3. Refine and optimize:
   - [ ] Review all controllers:
     - [ ] Optimize database queries using includes, joins, etc.
   - [ ] Implement proper error handling:
     - [ ] Add rescue blocks for potential exceptions
     - [ ] Provide user-friendly error messages
   - [ ] Optimize asset loading:
     - [ ] Minimize and compress CSS/JS files
     - [ ] Use asset precompilation for production

4. Documentation:
   - [ ] Update README.md:
     - [ ] Add detailed setup instructions
     - [ ] List all features and functionalities
     - [ ] Include information about running tests
   - [ ] Add inline comments to complex parts of the code
   - [ ] Create user guide or wiki for the application

5. Final review:
   - [ ] Cross-check implemented features with original project description
   - [ ] Verify all audit scenarios pass
   - [ ] Perform security audit (e.g., check for SQL injection vulnerabilities, XSS protection)
   - [ ] Optimize database (add necessary indexes, review query performance)
   - [ ] Ensure code adheres to Ruby on Rails best practices and conventions