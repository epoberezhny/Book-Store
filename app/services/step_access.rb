class StepAccess < Rectify::Command
  STEPS = %i[address delivery payment confirm complete].freeze

  def initialize(order, step = nil)
    @order = order
    @step  = step
  end

  def call
    if empty_cart?
      broadcast(:empty_cart)
    elsif access_allowed?
      broadcast(:allowed)
    else
      broadcast(:denied, last_allowed)
    end
  end

  def last_allowed
    STEPS.each_with_index do |step, index|
      return STEPS[index - 1] unless check(step)
    end
  end

  private

  def empty_cart?
    @step != :complete && !@order.items.exists?
  end

  def check(step)
    send(step)
  end

  def access_allowed?
    steps_for_check.map { |step| check(step) }.reduce(:&)
  end

  def steps_for_check
    STEPS.take( STEPS.index(@step) + 1 )
  end

  def address
    true
  end

  def delivery
    @order.shipping_address.present? && @order.billing_address.present?
  end

  def payment
    @order.shipping_method.present?
  end

  def confirm
    @order.credit_card.present?
  end

  def complete
    @order.in_queue?
  end
end
