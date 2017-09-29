class BestSellers < Rectify::Query
  def query
    Book.includes(:authors).where(id: best_sellers_ids)
  end

  private

  def best_sellers_ids
    Category.all.map do |category|
      category.books.order(order_items_count: :desc).limit(1).ids
    end
  end
end
