class Address < ApplicationRecord
  FIELDS = %i[id first_name last_name address_line city zip country_id phone].freeze

  belongs_to :country
  belongs_to :addressable, polymorphic: true

  validates *FIELDS.without(:id),
    presence: true
  validates :zip,
    length: { maximum: 10 },
    format: { with: /\A[\d-]+\z/ }
  validates :phone,
    length: { maximum: 15 },
    format: { with: /\A\+\d+\z/ }
  validates :first_name, :last_name, :city,
    length: { maximum: 50 },
    format: { with: /\A[a-zA-Z]+\z/ }
  validates :address_line,
    length: { maximum: 50 },
    format: { with: /\A[ a-zA-Z\d,-]+\z/ }
end
