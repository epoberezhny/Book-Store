class ShippingMethodDecorator < ApplicationDecorator
  extend PriceFormatter

  format_price :price

  def days
    I18n.t('range', min: min_days, max: max_days)
  end
end
