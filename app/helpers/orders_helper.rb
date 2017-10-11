module OrdersHelper
  def active_filter
    status = params[:status]
    return status if FilterOrders::ALLOWED_STATUSES.include?(status)
    FilterOrders::ALLOWED_STATUSES.first
  end
end