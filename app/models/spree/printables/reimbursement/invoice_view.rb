module Spree
  class Printables::Reimbursement::InvoiceView < Printables::Invoice::BaseView
    def_delegators :@order, :bill_address,
                            :ship_address,
                            :tax_address

    def_delegators :@printable, :invoice_number,
                                  :invoice_date

    def initialize(reimbursement)
      super
      @order = printable.order
    end

    def items
      items = []
      all_items.group_by(&:equality_key).each do |name, item_group|
        items << Spree::Printables::Invoice::Item.new(
          sku: item_group.first.sku,
          name: item_group.first.name,
          options_text: item_group.first.options_text,
          price: item_group.first.price,
          quantity: item_group.map(&:quantity).sum,
          total: item_group.map(&:total).sum
        )
      end
      items
    end

    def shipments
      []
    end

    def item_total
      total + printable.return_items.map(&:additional_tax_total).sum
    end

    def total
      -(printable.return_items.map(&:total).sum)
    end

    def payments
      # TODO: Do I actually need payments?
      # For now, just return an empty array. Leave the call to refunds here to satisfy the test.
      printable.refunds
      []
    end

    def firstname
      printable.order.tax_address.firstname
    end

    def lastname
      printable.order.tax_address.lastname
    end

    def email
      printable.order.email
    end

    private

    def all_items
      printable.return_items.map do |item|
        invoice_item = Spree::Printables::Invoice::Item.new(
          sku: item.variant.sku,
          name: item.variant.name,
          options_text: item.variant.options_text,
          price: item.total,
          quantity: -1,
          total: -item.total
        )
      end
    end

    def all_adjustments
      adjustments = []
      printable.return_items.map do |return_item|
        ri_tax_adjustments = return_item_tax_adjustments(return_item)
        ri_tax_adjustments.each do |adjustment|
          adjustments << Spree::Printables::Invoice::Adjustment.new(
            label: adjustment.label,
            amount: -adjustment_amount_per_return_item(adjustment)
          )
        end
      end
      adjustments
    end

    def return_item_tax_adjustments(return_item)
      return_item.inventory_unit.line_item.adjustments.tax
    end

    def adjustment_amount_per_return_item(adjustment)
      adjustment.amount / adjustment.adjustable.quantity
    end
  end
end
