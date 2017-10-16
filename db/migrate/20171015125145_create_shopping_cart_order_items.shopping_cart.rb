# This migration comes from shopping_cart (originally 20171011234603)
class CreateShoppingCartOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_order_items do |t|
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2
      t.references :product, polymorphic: true, index: { name: :productable_index }
      t.references :order, foreign_key: { to_table: :shopping_cart_orders }

      t.timestamps
    end
  end
end
