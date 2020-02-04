# frozen_string_literal: true

module Spree
  class Printables::Order::InvoiceView < Printables::Invoice::BaseView
    delegate  :tax_address, to: :@printable
    delegate  :item_total, to: :@printable
    delegate  :total, to: :@printable
    delegate  :payments, to: :@printable
    delegate  :shipments, to: :@printable
    delegate  :email, to: :@printable
    delegate  :bill_address, to: :@printable
    delegate  :ship_address, to: :@printable

    def items
      printable.line_items.map do |item|
        Spree::Printables::Invoice::Item.new(
          sku: item.variant.sku,
          name: item.variant.name,
          options_text: item.variant.options_text,
          price: item.price,
          quantity: item.quantity,
          total: item.total
        )
      end
    end

    def firstname
      printable.tax_address.firstname
    end

    def lastname
      printable.tax_address.lastname
    end

    private

    def all_adjustments
      printable.all_adjustments.eligible
    end
  end
end
