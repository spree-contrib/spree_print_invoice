# frozen_string_literal: true

require 'forwardable'

module Spree
  class Printables::BaseView
    extend Forwardable
    extend Spree::DisplayMoney

    attr_reader :printable

    money_methods :item_total, :total

    def initialize(printable)
      @printable = printable
    end

    def firstname
      raise NotImplementedError, 'Please implement firstname'
    end

    def lastname
      raise NotImplementedError, 'Please implement lastname'
    end

    def email
      raise NotImplementedError, 'Please implement email'
    end

    def total
      raise NotImplementedError, 'Please implement total'
    end

    def number
      raise NotImplementedError, 'Please implement number'
    end
  end
end
