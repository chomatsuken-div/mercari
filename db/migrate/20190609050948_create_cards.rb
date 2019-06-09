class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.references :user
      t.string :pay_id
      t.string :customer_id
      t.timestamps
    end
  end
end
