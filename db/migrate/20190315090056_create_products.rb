class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, index: true, null: false
      t.text :detail
      t.integer :shipping_fee
      t.integer :expected_date
      t.integer :price, index: true, null: false
      t.integer :like_count, default: 0
      t.string :status, null: false
      t.string :size
      t.integer :transaction_status, null: false, default: 0
      t.integer :purchaser_id
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
