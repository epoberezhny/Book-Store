# This migration comes from shopping_cart (originally 20171011234758)
class CreateShoppingCartAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_addresses do |t|
      t.references :addressable, polymorphic: true, index: { name: :addressable_index }
      t.references :country, foreign_key: { to_table: :shopping_cart_countries }
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :address_line
      t.string :zip
      t.string :phone

      t.timestamps
    end
  end
end
