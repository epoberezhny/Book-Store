# This migration comes from shopping_cart (originally 20171009231128)
class CreateShoppingCartCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_coupons do |t|
      t.string :code
      t.integer :discount
      t.date :expire

      t.timestamps
    end
  end
end
