class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.text :description
      t.integer :quantity
      t.string :cover
      t.string :additional_images, array: true
      t.integer :year
      t.json :dimensions
      t.integer :order_items_count, default: 0

      t.timestamps
    end
  end
end
