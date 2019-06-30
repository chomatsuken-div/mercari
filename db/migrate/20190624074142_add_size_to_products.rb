class AddSizeToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :size, :string
    add_column :products, :category_root_id, :integer
  end
end
