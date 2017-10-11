class CreditCard < ApplicationRecord
  FIELDS = %i[id name_on_card cvv number month_year].freeze

  belongs_to :order

  validates *FIELDS.without(:id),
    presence: true
  validates :number,
    length: { in: 16..20 },
    format: { with: /\A\d+\z/ }
  validates :cvv,
    length: { in: 3..4 },
    format: { with: /\A\d+\z/ }
  validates :name_on_card,
    length: { maximum: 50 },
    format: { with: /\A[ a-zA-Z]+\z/ }
  validates :month_year,
    format: { with: /\A(?:0[1-9]|1[0-2])\/\d{2}\z/ }

  validate :check_date

  private

  def check_date
    return if errors[:month_year].present?
    month, year = month_year.split('/').map!(&:to_i)
    year  += 2_000
    return if (Date.current - Date.new(year, month)) < 0
    errors[:month_year] << I18n.t('validators.expired_card')
  end
end
