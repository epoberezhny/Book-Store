class CreditCardDecorator < ApplicationDecorator
  def formatted_number
    ('*' * 12) << number.slice(12, 15)
  end
end
