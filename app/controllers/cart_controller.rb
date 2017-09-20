class CartController < ApplicationController
  def index
    @items = current_order.items.order(:created_at).includes(:book)
  end
end
