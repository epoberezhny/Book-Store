class CreditCardDecorator < ApplicationDecorator
  def formatted_number
    ('*' * 12) << number.slice(13, 16)
  end
end
