class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :add_to_cart]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]

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
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end


  # PATCH/PUT /products/1

  def update
    @product = Product.find(params[:id])
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
    current_cart.add_product(@product, quantity)
    redirect_to @product, notice: "#{@product.title} added to your cart."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def check_owner
    unless @product.user == current_user
      redirect_to products_path, alert: "You are not authorized to perform this action."
    end
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :category_id)
  end
end
