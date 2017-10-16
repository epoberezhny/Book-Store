# This migration comes from shopping_cart (originally 20171009230006)
class CreateShoppingCartCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_countries do |t|
      t.string :name

      t.timestamps
    end
  end
end
