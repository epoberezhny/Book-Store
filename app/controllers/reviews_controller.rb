class ReviewsController < ApplicationController
  def create
    CreateReview.call(current_user, params) do
      on(:valid)   { flash[:notice] = t('.valid')   }
      on(:invalid) { flash[:alert]  = t('.invalid') }
    end

    redirect_back(fallback_location: book_path(params[:book_id]))
  end
end
