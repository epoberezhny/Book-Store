module BooksHelper
  def active_sorting
    SortBooks.active_sorting(params[:sort_by])
  end

  def active_category
    params[:category]&.humanize || 'All'
  end

  def category_class(name)
    active_category == name ? 'filter-link in-gold-500' : 'filter-link'
  end

  def return_path
    books_path(category: params[:category], sort_by: params[:sort_by])
  end
end
