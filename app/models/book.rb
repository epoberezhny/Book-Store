class Book < ApplicationRecord
  mount_uploader  :cover, CoverUploader
  mount_uploaders :additional_images, AdditionalImagesUploader

  belongs_to :category, counter_cache: true

  has_many :reviews, -> { where(state: :approved) }

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials

  validates :title, :price, :description, :quantity, :year, :dimensions,
    presence: true
  validates :quantity,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price,
    numericality: { greater_than: 0 }

  validates_with DimensionsValidator, if: -> { dimensions.present? }

  before_save :prepare_dimensions

  scope :latest,   ->(num) { order(created_at: :desc).limit(num) }
  scope :for_show, -> { includes(:authors, :materials, reviews: :user) }

  def in_stock?
    quantity.positive?
  end

  private

  def prepare_dimensions
    return unless dimensions_changed?
    dimensions.each { |dimension, value| dimensions[dimension] = value.to_f }
  end
end
