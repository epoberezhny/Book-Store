class Material < ApplicationRecord
  has_and_belongs_to_many :books

  validates :name,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 50 },
    format:     { with: /\A[ a-zA-Z]+\z/ }
end
