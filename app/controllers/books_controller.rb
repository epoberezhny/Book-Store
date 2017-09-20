class BooksController < ApplicationController
  helper_method :books_count

  def index
    books =
      Paginate.new(Book.includes(:authors), params[:page]) |
      FilterBooks.new(params[:category]) |
      SortBooks.new(params[:sort_by])

    @books = books.query.decorate
  end

  def show
    @book   = Book.for_show.find(params[:id]).decorate
    @review = Review.new(score: 1)
  end

  private

  def books_count
    @books_count ||= categories.sum { |category| category.books.size }
  end
end
