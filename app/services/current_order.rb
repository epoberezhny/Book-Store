class CurrentOrder < SimpleDelegator
  def call
    order_from_user || order_from_cookie || Order.new
  end

  private

  def order_from_user
    return unless user_signed_in?
    user_order = current_user.orders.in_progress.last || current_user.orders.new
    if order_from_cookie
      user_order.merge!(order_from_cookie)
      cookies.delete(:cart_id)
    end
    user_order
  end

  def order_from_cookie
    @order_from_cookie ||= begin
      order_id = cookies.encrypted[:cart_id]
      return unless order_id
      Order.in_progress.find_by(id: order_id)
    end
  end

  def cookies
    __getobj__.send(:cookies)
  end
end
