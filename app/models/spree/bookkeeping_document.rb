module Spree
  class BookkeepingDocument < ActiveRecord::Base
    PERSISTED_ATTRS = [
      :firstname,
      :lastname,
      :email,
      :total,
      :number
    ]

    # Spree::BookkeepingDocument cares about creating PDFs. Whenever it needs to know
    # anything about the document to send to the view, it asks a view object.
    #
    # +printable+ should be an Object, such as Spree::Order or Spree::Shipment.
    # template should be a string, such as "invoice" or "packaging_slip"
    #
    belongs_to :printable, polymorphic: true
    validates :printable, :template, presence: true
    validates *PERSISTED_ATTRS, presence: true, if: -> { self.persisted? }
    scope :invoices, -> { where(template: 'invoice') }

    before_create :copy_view_attributes
    after_save :after_save_actions

    # An instance of Spree::Printable::#{YourModel}::#{YourTemplate}Presenter
    #
    def view
      @_view ||= view_class.new(printable)
    end

    def date
      created_at.to_date
    end

    def template_name
      "spree/printables/#{single_lower_case_name(printable.class.name)}/#{template}"
    end

    # If the document is called from the view with some method it doesn't know,
    # just call the view object. It should know.
    def method_missing(method_name, *args, &block)
      if view.respond_to? method_name
        view.send(method_name, *args, &block)
      else
        super
      end
    end

    def document_type
      "#{printable_type.demodulize.tableize.singularize}_#{template}"
    end

    # Returns the given template as pdf binary suitable for Rails send_data
    #
    # If the file is already present it returns this
    # else it generates a new file, stores and returns this.
    #
    # You can disable the pdf file generation with setting
    #
    #   Spree::PrintInvoice::Config.store_pdf to false
    #
    def pdf
      if Spree::PrintInvoice::Config.store_pdf
        send_or_create_pdf
      else
        render_pdf
      end
    end

    # = The PDF file_name
    #
    def file_name
      @_file_name ||= "#{template}-D#{id}-N#{number}.pdf"
    end

    # = PDF file path
    #
    def file_path
      @_file_path ||= Rails.root.join(storage_path, "#{file_name}")
    end

    # = PDF storage folder path for given template name
    #
    # Configure the storage path with +Spree::PrintInvoice::Config.storage_path+
    #
    # Each template type gets it own pluralized folder inside
    # of +Spree::PrintInvoice::Config.storage_path+
    #
    # == Example:
    #
    #   storage_path('invoice') => "tmp/pdf_prints/invoices"
    #
    # Creates the folder if it's not present yet.
    #
    def storage_path
      storage_path = Rails.root.join(Spree::PrintInvoice::Config.storage_path, template.pluralize)
      FileUtils.mkdir_p(storage_path)
      storage_path
    end

    # Renders the prawn template for give template name in context of ActionView.
    #
    # Prawn templates need to be placed in the correct folder. For example, for a PDF from
    # a Spree::Order with the invoice template, it would be
    # the +app/views/spree/printables/order/invoices+ folder.
    #
    # Assigns +@doc+ instance variable
    #
    def render_pdf
      ApplicationController.render(
        template: "#{template_name}.pdf.prawn",
        assigns: { doc: self }
      )
    end

    private

    def copy_view_attributes
      PERSISTED_ATTRS.each do |attr|
        send("#{attr}=", view.send(attr))
      end
    end

    # For a Spree::Order printable and an "invoice" template,
    # you would get "spree/documents/order/invoice_view"
    # --> Spree::Printables::Order::InvoiceView
    #
    def view_class
      @_view_class ||= "#{template_name}_view".classify.constantize
    end

    def single_lower_case_name(class_string)
      @_single_lower_class_name ||= class_string.demodulize.tableize.singularize
    end

    # Sends stored pdf for given template from disk.
    #
    # Renders and stores it if it's not yet present.
    #
    def send_or_create_pdf
      unless File.exist?(file_path)
        File.open(file_path, 'wb') { |f| f.puts render_pdf }
      end

      IO.binread(file_path)
    end
  end
end
