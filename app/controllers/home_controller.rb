class HomeController < ApplicationController
  def index
    @latest_books = Book.includes(:authors).latest(3).decorate
    @best_sellers = BestSellers.new.query.map(&:decorate)
  end
end
