class OrderMailer < ApplicationMailer
    def order_confirmation(order, cart, restaurant)
      @order = order
      @cart = cart
      @restaurant = restaurant
      mail(to: @order.email, subject: 'Order Confirmation')
    end
  end