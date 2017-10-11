class Checkouter < Rectify::Command
  def initialize(order, params, step)
    @order  = order
    @params = params
    @step   = step
  end

  def call
    if @step == :confirm
      @order.confirm
    else
      @order.assign_attributes( send("#{@step}_params") )
    end

    broadcast(:ok, @order)
  end

  private

  def address_params
    if @params[:use_billing_address]
      @params[:order][:shipping_address_attributes] =
        @params[:order][:billing_address_attributes].merge(
          id: @params[:order][:shipping_address_attributes][:id]
        )
    end

    @params.require(:order).permit(
      billing_address_attributes:  Address::FIELDS,
      shipping_address_attributes: Address::FIELDS
    )
  end

  def payment_params
    @params.require(:order).permit(credit_card_attributes: CreditCard::FIELDS)
  end

  def delivery_params
    @params.require(:order).permit(:shipping_method_id)
  end
end
