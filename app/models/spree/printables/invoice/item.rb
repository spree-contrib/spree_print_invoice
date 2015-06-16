module Spree
  class Printables::Invoice::Item
    extend Spree::DisplayMoney

    attr_accessor :sku, :name, :options_text, :price, :quantity, :total

    money_methods :price, :total

    def initialize(args = {})
      args.each do |key, value|
        self.send("#{key}=", value)
      end
    end

    def equality_key
      [sku, name, options_text, price]
    end
  end
end
