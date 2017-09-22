class BookDecorator < ApplicationDecorator
  extend PriceFormatter

  decorates_association :authors
  decorates_association :reviews

  format_price :price

  def joined_authors
    authors.map(&:full_name).join(', ')
  end

  def joined_materials
    materials.map(&:name).join(', ')
  end

  def formatted_dimensions
    h, w, d = dimensions.values_at('h', 'w', 'd')
    height = I18n.t(:h)
    width  = I18n.t(:w)
    depth  = I18n.t(:d)
    "#{height}: #{h} x #{width}: #{w} x #{depth}: #{d}"
  end

  def btn_class
    in_stock? ? 'btn-primary' : 'disabled'
  end

  def disabled_class
    'disabled' unless in_stock?
  end

  def has_long_description?
    description.length > 300
  end

  def short_description
    description.truncate(300, separator: ' ')
  end

  def more_short_description
    description.truncate(90, separator: ' ', omission: '')
  end
end
