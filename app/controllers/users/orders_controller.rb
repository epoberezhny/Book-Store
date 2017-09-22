class Users::OrdersController < ApplicationController
  load_resource only: [:index]

  def index
    @orders = FilterOrders.new(@orders, params[:status]).query.decorate
  end

  def show
    @order = Order.for_show.find(params[:id]).decorate
    authorize! :show, @order.object
  end
end
