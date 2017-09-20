class Users::OrdersController < ApplicationController
  load_resource only: [:index]

  def index
    @orders = FilterOrders.new(@orders, params[:status]).query
  end

  def show
    @order = Order.for_show.find(params[:id])
    authorize! :show, @order
  end
end
