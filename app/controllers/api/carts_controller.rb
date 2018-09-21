class Api::CartsController < ApplicationController
  include JSONErrors
  before_action :set_cart, only: [:show, :update, :destroy]

  # GET /carts
  def index
    @carts = Cart.all

    render json: @carts
  end

  def add_product
    if products_params[:product_id].to_i.to_s != products_params[:product_id]
      render_400(message: 'product_id is invalid')
    elsif !products_params[:quantity].to_i.between?(1, 10)
      render_400(message: 'Quantity is invalid')
    else
      @cart = Cart.last
      @product = Product.find(products_params[:product_id])
      products_params[:quantity].to_i.times do
        @cart.products << @product
      end
      head :ok
    end
  end

  def delete_product
    @cart = Cart.last
    product_id = params[:product_id].to_i
    @purchase = @cart.carts_products.where(product_id: product_id).last
    @purchase.destroy
    head :ok
  end

  def cart
    @cart = Cart.last
    products = @cart.products
    actual_products = products.uniq
    products_arr = []
    total_sum = @cart.total_price
    actual_products.each do |product|
      id = product.id
      quantity = products.where(id: id).count
      sum = product.price * quantity
      products_arr << { id: id, quantity: quantity, sum: sum }
    end
    hash = {
      data:
        { total_sum: total_sum,
          products_count: products.count,
          products: products_arr
        }
    }
    json = JSON.generate(hash)
    render json: json
  end

  # GET /carts/1
  def show
    products = @cart.products
    actual_products = products.uniq
    products_arr = []
    actual_products.each do |product|
      id = product.id
      quantity = products.where(id: id).count
      sum = product.price * quantity
      products_arr << { id: id, quantity: quantity, sum: sum }
    end
    hash = {
      data:
        { total_sum: 500,
          products_count: 6,
          products: products_arr
        }
    }
    json = JSON.generate(hash)
    render json: json
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cart_params
      params.require(:cart).permit(:content, :cookie)
    end

    def products_params
      params.permit(:product_id, :quantity)
    end
end
