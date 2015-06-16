module Spree
  class Printables::Shipment::PackagingSlipView
    def initialize(shipment)
      @shipment = shipment
    end

    def display_number
      @shipment.number
    end

    def date
      @shipment.shipped_at
    end

    def shipment
      nil
    end
  end
end
