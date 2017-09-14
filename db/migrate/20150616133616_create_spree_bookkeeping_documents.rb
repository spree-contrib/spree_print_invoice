class CreateSpreeBookkeepingDocuments < SpreeExtension::Migration[4.2]
  def up
    create_table :spree_bookkeeping_documents do |t|
      t.references :printable, polymorphic: true
      t.string :template
      t.string :number
      t.string :firstname
      t.string :lastname
      t.string :email
      t.decimal :total, precision: 12, scale: 2

      t.timestamps null: false
    end

    Spree::Order.complete.where.not(invoice_number: nil).find_each do |order|
      order.pdfs.create(
        template: 'invoice',
        number: order.invoice_number,
        created_at: order.completed_at.to_date
      )
    end

    remove_column :spree_orders, :invoice_number, :string
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
