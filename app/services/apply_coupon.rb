class ApplyCoupon < Rectify::Command
  def initialize(order, code)
    @order = order
    @code  = code
  end

  def call
    coupon = Coupon.find_by(code: @code)

    if coupon.blank?
      broadcast(:null)
    elsif coupon&.expired?
      broadcast(:expired)
    else
      @order.update(coupon: coupon)
      broadcast(:applied)
    end
  end
end
