class CreditCard < ApplicationRecord
  FIELDS = %i[id name_on_card cvv number month_year].freeze

  belongs_to :order

  validates *FIELDS.without(:id),
    presence: true
  validates :number,
    length: { is: 16 },
    format: { with: /\A\d+\z/ }
  validates :cvv,
    length: { in: 3..4 },
    format: { with: /\A\d+\z/ }
  validates :name_on_card,
    length: { maximum: 50 },
    format: { with: /\A[ a-zA-Z]+\z/ }
  validates :month_year,
    format: { with: /\A(?:0[1-9]|1[0-2])\/\d{2}\z/ }
end
