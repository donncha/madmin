class AddAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :zip
      t.references :user

      t.timestamps
    end
  end
end
