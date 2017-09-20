class Country < ApplicationRecord
  has_many :shipping_methods

  validates :name,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 50 },
    format:     { with: /\A[ \-,a-zA-Z]+\z/ }
end
