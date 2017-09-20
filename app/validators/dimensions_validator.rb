class DimensionsValidator < ActiveModel::Validator
  DIMENSIONS = %w[h w d].freeze

  def validate(record)
    filter_dimensions(record)
    validate_numericality(record)
  end

  private

  def filter_dimensions(record)
    record.dimensions.keep_if do |dimension, _value|
      DIMENSIONS.include?(dimension)
    end
  end

  def validate_numericality(record)
    return if DIMENSIONS.all? do |dimension|
      record.dimensions[dimension].to_f > 0
    end
    record.errors.add(
      :dimensions,
      'all(H, W and D) needs to be numeric greater than 0'
    )
  end
end
