class UpdateOrder < Rectify::Command
  def initialize(order, params)
    @order   = order
    @params  = params
  end

  def call
    @order.assign_attributes(order_params)
    authorize! :update, :order_items

    if @order.save
      broadcast(:valid)
    else
      broadcast(:invalid)
    end
  end

  private

  def order_params
    @params.require(:order).permit(items_attributes: [:id, :quantity])
  end
end
