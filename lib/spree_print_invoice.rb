require 'spree_core'
require 'spree_print_invoice/engine'
require 'spree_print_invoice/version'
require 'prawn_handler'
require 'coffee_script'

module Spree
  module PrintInvoice
    def self.config(&block)
      yield(Spree::PrintInvoice::Config)
    end
  end
end