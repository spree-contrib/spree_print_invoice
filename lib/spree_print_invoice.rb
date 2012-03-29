require 'spree_print_invoice/engine'
require 'prawn_handler'

module Spree
  module PrintInvoice
    def self.config(&block)
      yield(Spree::GoogleBase::Config)
    end
  end
end
