class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :book, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
