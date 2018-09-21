class Api::CartsController < ApplicationController
  include JSONErrors
  before_action :set_cart, only: %i[cart add_product delete_product]

  def add_product
    return unless product_params_valid?

    @product = Product.find(products_params[:product_id])
    products_params[:quantity].to_i.times do
      @cart.products << @product
    end
    head :ok
  end

  def delete_product
    product_id = params[:product_id].to_i
    render_400 && return if params[:product_id].nil?

    @purchase = @cart.carts_products.find_by_product_id(product_id)
    if @purchase.nil?
      render_404('product_not_found', 'there is no such product in cart')
      return
    end

    @purchase.destroy
    head :ok
  end

  def cart
    products = @cart.products
    products_arr = []
    products.uniq.each do |product|
      id = product.id
      quantity = products.where(id: id).count
      sum = product.price * quantity
      products_arr << { id: id, quantity: quantity, sum: sum }
    end
    hash = {
      data:
        { total_sum: @cart.total_price,
          products_count: products.count,
          products: products_arr
        }
    }
    json = JSON.generate(hash)
    render json: json
  end

  private

  def set_cart
    @cart = Cart.last
  end

  def products_params
    params.permit(:product_id, :quantity)
  end

  def product_params_valid?
    unless products_params[:quantity].to_i.between?(1, 10)
      render_400(message: 'Quantity is invalid')
      return false
    end
    if products_params[:product_id].to_i.to_s != products_params[:product_id]
      render_400(message: 'product_id is invalid')
      return false
    end
    true
  end
end
