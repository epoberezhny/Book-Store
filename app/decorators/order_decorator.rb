class OrderDecorator < ApplicationDecorator
  extend PriceFormatter

  decorates_association :items
  decorates_association :shipping_method
  decorates_association :credit_card

  format_price :items_subtotal, :delivery_price, :total

  def formatted_coupon_discount
    (-coupon_discount).to_s(:currency)
  end

  def formatted_completed_at
    completed_at.strftime('%Y-%m-%d')
  end

  def status
    I18n.t(state, scope: 'orders_filters')
  end

  def number
    'R' + '0' * (8 - id.digits.size) + id.to_s
  end
end
