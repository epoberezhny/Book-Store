class CreateReview < Rectify::Command
  def initialize(user, params)
    @user   = user
    @params = params
  end

  def call
    authorize! :write, :review

    review = @user.reviews.new(review_params)
    review.book = book

    if review.save
      broadcast(:valid)
    else
      broadcast(:invalid)
    end
  end

  private

  def book
    Book.find(@params[:book_id])
  end

  def review_params
    @params.require(:review).permit(:score, :title, :body)
  end
end
