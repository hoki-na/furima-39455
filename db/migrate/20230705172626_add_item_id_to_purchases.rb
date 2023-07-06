class AddItemIdToPurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :item_id, :integer
  end
end
