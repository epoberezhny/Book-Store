class AddOrderItem < Rectify::Command
  def initialize(order, params)
    @order  = order
    @params = params
  end

  def call
    @order.save if @order.new_record?
    
    @order.add_item(item)

    if @order.save
      broadcast(:ok, @order)
    else
      broadcast(:error)
    end
  end

  private

  def item
    @item ||= OrderItem.new(order_item_params)
  end

  def order_item_params
    @params.require(:order_item).permit(:book_id, :quantity)
  end
end
