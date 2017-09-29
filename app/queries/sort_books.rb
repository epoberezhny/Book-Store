class SortBooks < Rectify::Query
  include SortingQuery
  
  type :newest,     order: { created_at: :desc }
  type :popular,    order: { order_items_count: :desc }
  type :price,      order: { price: :asc }
  type :price_desc, order: { price: :desc }
  type :title,      order: { title: :asc }, default: true
  type :title_desc, order: { title: :desc }

  def initialize(name)
    @name = name
  end

  def query
    Book.order( sorting_order(@name) )
  end
end
