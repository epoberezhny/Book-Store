class ReviewDecorator < ApplicationDecorator
  def formatted_date
    created_at.strftime('%d/%m/%y')
  end
end
