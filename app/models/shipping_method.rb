class ShippingMethod < ApplicationRecord
  belongs_to :country

  validates :min_days, :max_days, :name, :price,
    presence: true
  validates :price,
    numericality: { greater_than: 0 }
  validates :name,
    uniqueness: { scope: :country_id }
  validates :min_days, :max_days,
    numericality: { only_integer: true, greater_than: 0 }

  validate :right_days_range

  private

  def right_days_range
    return if errors.present? || min_days < max_days
    errors[:base] << I18n.t('validators.invalid_range')
  end
end
