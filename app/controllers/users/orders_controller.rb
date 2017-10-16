class Users::OrdersController < ApplicationController
  before_action :authenticate_user!
  
  load_resource only: [:index], class: 'ShoppingCart::Order'

  def index
    @orders = FilterOrders.new(@orders, params[:status]).query.decorate
  end

  def show
    @order = ShoppingCart::Order.for_show.find(params[:id]).decorate
    authorize! :show, @order.object
  end
end
