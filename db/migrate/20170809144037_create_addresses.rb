class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :city
      t.references :country, foreign_key: true
      t.string :address_line
      t.string :zip
      t.string :phone

      t.timestamps
    end
  end
end
