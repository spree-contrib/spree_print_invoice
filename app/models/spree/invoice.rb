class Spree::Invoice < ActiveRecord::Base
  belongs_to :invoiceable, polymorphic: true
  validates :invoiceable, presence: true

  before_save :set_date
  before_save :set_number, if: :use_sequential_number?
  after_save :increase_invoice_number, if: :use_sequential_number?

  # Returns the given template as pdf binary suitable for Rails send_data
  #
  # If the file is already present it returns this
  # else it generates a new file, stores and returns this.
  #
  # You can disable the pdf file generation with setting
  #
  #   Spree::PrintInvoice::Config.store_pdf to false
  #
  def pdf_file(template)
    if Spree::PrintInvoice::Config.store_pdf
      send_or_create_pdf(template)
    else
      render_pdf(template)
    end
  end

  # = The PDF filename
  #
  # Tries to take invoice_number attribute.
  # If this is not present it takes the order number.
  #
  def pdf_filename
    number.present? ? number : invoiceable.number
  end

  # = PDF file path for template name
  #
  def pdf_file_path(template)
    Rails.root.join(pdf_storage_path(template), "#{pdf_filename}.pdf")
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
  #   pdf_storage_path('invoice') => "tmp/pdf_prints/invoices"
  #
  # Creates the folder if it's not present yet.
  #
  def pdf_storage_path(template)
    storage_path = Rails.root.join(Spree::PrintInvoice::Config.storage_path, template.pluralize)
    FileUtils.mkdir_p(storage_path)
    storage_path
  end

  # Renders the prawn template for give template name in context of ActionView.
  #
  # Prawn templates need to be placed in +app/views/spree/admin/invoices/+ folder.
  #
  # Assigns +@invoice+ instance variable
  #
  def render_pdf(template)
    ActionView::Base.new(
      ActionController::Base.view_paths,
      {invoice: self, template: template}
    ).render(template: "spree/admin/invoices/#{template}.pdf.prawn")
  end

  private

  # Sends stored pdf for given template from disk.
  #
  # Renders and stores it if it's not yet present.
  #
  def send_or_create_pdf(template)
    file_path = pdf_file_path(template)

    unless File.exist?(file_path)
      File.open(file_path, 'wb') { |f| f.puts render_pdf(template) }
    end

    IO.binread(file_path)
  end

  ### AR Callback actions

  def set_date
    self.date ||= Date.today
  end

  def set_number
    self.number ||= Spree::PrintInvoice::Config.next_number
  end

  def increase_invoice_number
    Spree::PrintInvoice::Config.increase_invoice_number!
  end

  def use_sequential_number?
    @_use_sequential_number ||= Spree::PrintInvoice::Config.use_sequential_number?
  end
end
