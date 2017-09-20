class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :discount
      t.date :expire

      t.timestamps
    end
  end
end
