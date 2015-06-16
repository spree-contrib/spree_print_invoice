module Spree
  class Printables::Order::PackagingSlipView < Printables::Order::InvoiceView
    def number
      printable.number
    end

    def after_save_actions
    end
  end
end
