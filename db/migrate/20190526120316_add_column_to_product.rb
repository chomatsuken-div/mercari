class AddColumnToProduct < ActiveRecord::Migration[5.1]
  def change

    remove_column :products, :shipping_fee, :integer
    remove_column :products, :size, :integer
    remove_column :products, :transaction_status, :integer
    remove_column :products, :purchaser_id, :integer
    remove_column :products, :status, :string
    remove_column :products, :expected_date, :integer

    add_column :products, :state_id, :integer, null: false
    add_column :products, :shopping_fee_id, :integer, null: false
    add_column :products, :prefecture_code, :integer, null: false
    add_column :products, :brand_id, :integer
    add_column :products, :status, :integer, null: false, default: 0
    add_column :products, :expected_date_id, :integer, null: false
    add_column :products, :category_id, :integer, null:false
  end

end
