class CartsController < ApplicationController
  def show
    @order = current_order.decorate
    @items = current_order.items.order(:created_at).includes(:book).decorate
  end
end
