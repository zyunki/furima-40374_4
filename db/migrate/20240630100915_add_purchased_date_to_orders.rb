class AddPurchasedDateToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :purchased_date, :date
  end
end
