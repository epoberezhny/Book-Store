class Coupon < ApplicationRecord
  validates :code, :discount, :expire,
    presence: true
  validates :code,
    uniqueness: true,
    length:     { maximum: 20 },
    format:     { with: /\A[\w]+\z/ }
  validates :discount,
    numericality: { only_integer: true, greater_than: 0, less_than: 100 }

  def expired?
    (Date.current - expire) > 0
  end

  def multiplier
    discount * 0.01
  end
end
