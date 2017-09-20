class DeleteOrderItem < Rectify::Command
  def initialize(order, params)
    @order  = order
    @params = params
  end

  def call
    @order.items.find(@params[:id]).destroy
    @order.save
  end
end
