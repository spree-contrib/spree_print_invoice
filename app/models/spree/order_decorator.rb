# frozen_string_literal: true

module Spree
  module OrderDecorator
    def self.prepended(base)
      base.has_many :bookkeeping_documents, as: :printable, dependent: :destroy
      base.has_one :invoice, -> { where(template: 'invoice') },
                   class_name: 'Spree::BookkeepingDocument',
                   as: :printable

      base.has_one :packaging_slip, -> { where(template: 'packaging_slip') },
                   class_name: 'Spree::BookkeepingDocument',
                   as: :printable

      base.delegate :number, :date, to: :invoice, prefix: true

      # Create a new invoice before transitioning to complete
      #
      base.state_machine.before_transition to: :complete, do: :generate_bookkeeping_documents
    end

    def generate_bookkeeping_documents
      bookkeeping_documents.create(template: 'invoice')
      bookkeeping_documents.create(template: 'packaging_slip')
    end
  end
end
::Spree::Order.prepend Spree::OrderDecorator
