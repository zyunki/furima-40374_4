class RenameCommentsToOrders < ActiveRecord::Migration[7.0]
  def change
    rename_table :comments, :orders
  end
end
