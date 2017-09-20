class OrdersController < ApplicationController
  def update
    UpdateOrder.call(current_order, params) do
      on(:valid)   { flash[:notice] = t('.valid')   }
      on(:invalid) { flash[:alert]  = t('.invalid') }
    end

    redirect_back(fallback_location: cart_path)
  end

  def apply_coupon
    ApplyCoupon.call(current_order, params[:coupon][:code]) do
      on(:expired) { flash[:alert]  = t('.expired') }
      on(:applied) { flash[:notice] = t('.applied') }
      on(:null)    { flash[:alert]  = t('.null')    }
    end

    redirect_back(fallback_location: cart_path)
  end
end
