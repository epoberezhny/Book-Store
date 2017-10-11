class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.decimal :total, precision: 10, scale: 2
      t.decimal :items_subtotal, precision: 10, scale: 2
      t.string :state
      t.references :user, foreign_key: true
      t.references :shipping_method, foreign_key: true
      t.references :coupon, foreign_key: true
      t.integer :total_quantity, default: 0
      t.datetime :completed_at

      t.timestamps
    end
  end
end
