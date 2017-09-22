class OrderItemDecorator < ApplicationDecorator
  extend PriceFormatter

  decorates_association :book

  format_price :total
end
