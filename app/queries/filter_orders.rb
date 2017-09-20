class FilterOrders < Rectify::Query
  ALLOWED_STATUSES = %w[in_queue in_delivery delivered canceled].freeze

  def initialize(orders, status)
    @orders = orders
    @status = status
  end

  def query
    @orders.send(status)
  end

  private

  def status
    return @status if ALLOWED_STATUSES.include?(@status)
    ALLOWED_STATUSES.first
  end
end