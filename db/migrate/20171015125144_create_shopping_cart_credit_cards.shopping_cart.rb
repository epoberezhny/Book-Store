# This migration comes from shopping_cart (originally 20171011234114)
class CreateShoppingCartCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_credit_cards do |t|
      t.references :order, foreign_key: { to_table: :shopping_cart_orders }
      t.string :cvv
      t.string :number
      t.string :name_on_card
      t.string :month_year

      t.timestamps
    end
  end
end
