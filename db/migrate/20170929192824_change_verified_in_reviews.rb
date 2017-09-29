class ChangeVerifiedInReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :verified, :boolean, default: false, null: false 
  end
end
