class FilterBooks < Rectify::Query
  def initialize(category)
    @category = category
  end

  def query
    return Book.all if @category.blank?
    category_name = @category.humanize
    Book.joins(:category).where(categories: { name: category_name })
  end
end
