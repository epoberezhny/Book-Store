class CreditCardDecorator < ApplicationDecorator
  def formatted_number
    number.gsub(/\d{12}/, '*' * 12)
  end
end