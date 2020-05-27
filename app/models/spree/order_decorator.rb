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
      base.state_machine.before_transition to: :complete, do: :invoice_for_order
    end

    # Backwards compatibility stuff. Please don't use these methods, rather use the
    # ones on Spree::BookkeepingDocument
    #
    def pdf_file
      ActiveSupport::Deprecation.warn('This API has changed: Please use order.invoice.pdf instead')
      invoice.pdf
    end

    def pdf_filename
      ActiveSupport::Deprecation.warn('This API has changed: Please use order.invoice.file_name instead')
      invoice.file_name
    end

    def pdf_file_path
      ActiveSupport::Deprecation.warn('This API has changed: Please use order.invoice.pdf_file_path instead')
      invoice.pdf_file_path
    end

    def pdf_storage_path(template)
      ActiveSupport::Deprecation.warn('This API has changed: Please use order.{packaging_slip, invoice}.pdf_file_path instead')
      bookkeeping_documents.find_by!(template: template).file_path
    end

    def invoice_for_order
      bookkeeping_documents.create(template: 'invoice')
      bookkeeping_documents.create(template: 'packaging_slip')
    end
  end
end
::Spree::Order.prepend Spree::OrderDecorator