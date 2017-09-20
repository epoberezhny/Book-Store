class Category < ApplicationRecord
  has_many :books

  validates :name,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 50 }

  def to_param
    name.parameterize(separator: '_')
  end
end
