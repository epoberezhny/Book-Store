# This migration comes from shopping_cart (originally 20171009230822)
class CreateShoppingCartShippingMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_shipping_methods do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.integer :min_days
      t.integer :max_days
      t.references :country, foreign_key: { to_table: :shopping_cart_countries }

      t.timestamps
    end
  end
end
