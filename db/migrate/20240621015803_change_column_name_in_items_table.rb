class ChangeColumnNameInItemsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :shipping_days_id, :shipping_day_id
  end
end
