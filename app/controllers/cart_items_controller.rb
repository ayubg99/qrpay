class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    @cart_item = @cart.cart_items.build(cart_item_params)

    if @cart_item.save
      redirect_to restaurant_cart_path(@cart_item.cart.restaurant, @cart_item.cart), notice: 'Item was successfully added to cart.'
    else
      redirect_to restaurant_path(@cart_item.cart.restaurant), alert: 'Failed to add item to cart.'
    end
  end

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy

    render json: { message: 'Item removed successfully' }
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:food_item_id, :special_menu_id, :quantity)
  end
end