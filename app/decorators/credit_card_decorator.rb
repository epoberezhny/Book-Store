class CreditCardDecorator < ApplicationDecorator
  SHOWED_SYMBOLS = 4

  def formatted_number
    hidden_symbols = number.length - SHOWED_SYMBOLS
    ('*' * hidden_symbols) << number[-SHOWED_SYMBOLS, SHOWED_SYMBOLS]
  end
end
