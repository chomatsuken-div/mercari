class AddSellerToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :seller_id, :integer, null: false, foreign_key: true
    add_column :products, :buyer_id, :integer, foreign_key: true
  end
end
