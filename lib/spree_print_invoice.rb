require 'spree_core'
require 'spree_print_invoice/engine'
require 'prawn_handler'

module Spree
  module PrintInvoice
    def self.config(&block)
      yield(Spree::PrintInvoice::Config)
    end
  end
end
