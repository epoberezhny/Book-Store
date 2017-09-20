class OrderItem < ApplicationRecord
  belongs_to :book, counter_cache: true
  belongs_to :order

  validate :enough_books, if: -> { order.state == 'in_progress' }

  def total
    quantity * (price || book.price)
  end

  def set_price!
    self.price = book.price
  end

  def take_from_stock
    book.decrement(:quantity, quantity)
    book.save
  end

  def put_in_stock
    book.increment(:quantity, quantity)
    book.save
  end

  private

  def enough_books
    return if book.quantity >= quantity
    errors.add(:quantity, "It's not enough books in stock")
  end
end
