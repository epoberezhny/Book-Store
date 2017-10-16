# This migration comes from shopping_cart (originally 20171011224052)
class CreateShoppingCartOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_orders do |t|
      t.decimal :total, precision: 10, scale: 2
      t.decimal :items_subtotal, precision: 10, scale: 2
      t.string :state
      t.references ShoppingCart.config.customer_devise_scope, foreign_key: true
      t.references :shipping_method, foreign_key: { to_table: :shopping_cart_shipping_methods }
      t.references :coupon, foreign_key: { to_table: :shopping_cart_coupons }
      t.integer :total_quantity, default: 0
      t.datetime :completed_at

      t.timestamps
    end
  end
end
