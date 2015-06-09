class RemoveInvoiceDateColumn < ActiveRecord::Migration
  def change
    remove_column :spree_orders, :invoice_date, :date
  end
end
