module BooksHelper
  def active_sorting
    SortBooks.active_sorting(params[:sort_by])
  end

  def active_category
    params[:category]&.humanize || 'All'
  end

  def return_path
    books_path(category: params[:category], sort_by: params[:sort_by])
  end
end
