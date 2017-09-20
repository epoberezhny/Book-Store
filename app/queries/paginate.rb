class Paginate < Rectify::Query
  def initialize(relation, page, per = 12)
    @relation = relation
    @page     = page
    @per      = per
  end

  def query
    @relation.page(@page).per(@per).without_count
  end
end