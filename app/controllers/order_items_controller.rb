class OrderItemsController < ApplicationController
  def create
    AddOrderItem.call(current_order, params) do
      on(:ok) do |order|
        cookies.encrypted[:cart_id] = order.id unless user_signed_in?
        flash[:notice] = t('.added')
      end

      on(:error) do
        flash[:alert] = t('.error')
      end
    end

    redirect_back(fallback_location: books_path)
  end

  def destroy
    DeleteOrderItem.call(current_order, params)
    redirect_back(fallback_location: cart_path, notice: t('.destroyed'))
  end
end
