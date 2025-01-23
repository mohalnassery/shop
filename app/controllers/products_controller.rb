class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :add_to_cart]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :create, :update]

  # GET /products
  def index
    @products = Product.all.order(created_at: :desc)
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  # POST /products/1/add_to_cart
  def add_to_cart
    quantity = params[:quantity].to_i || 1
    if @current_cart.add_product(@product)
      redirect_to @product, notice: "#{@product.title} was added to your cart"
    else
      redirect_to @product, alert: "Could not add item to cart"
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def check_owner
    unless @product.user == current_user
      redirect_to products_path, alert: "You are not authorized to perform this action."
    end
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(
      :title, 
      :description, 
      :price, 
      :brand, 
      :model, 
      :condition, 
      :finish, 
      :image, 
      :category_id
    )
  end
end
