class AddInvoiceDetailsToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :invoice_number, :integer
    add_column :spree_orders, :invoice_date, :date
  end
end
