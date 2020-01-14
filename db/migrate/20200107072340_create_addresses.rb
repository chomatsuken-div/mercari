class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :last_name,          null: false
      t.string :first_name,         null: false
      t.string :last_name_kana,     null: false
      t.string :first_name_kana,    null: false
      t.integer :postcode,          null: false
      t.integer :prefecture_code,   null: false
      t.string   :address_city,      null: false
      t.string  :address_street,    null: false
      t.string  :address_building,  null: false
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
