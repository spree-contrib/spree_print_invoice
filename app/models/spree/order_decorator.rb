Spree::Order.class_eval do
  # Update the invoice number before transitioning to complete
  #
  state_machine.before_transition to: :complete, do: :update_invoice_number!

  # Updates +invoice_number+ without calling ActiveRecord callbacks
  #
  # Only updates if number is not already present and if
  # +Spree::PrintInvoice::Config.next_number+ is set and greater than zero.
  #
  def update_invoice_number!
    return unless Spree::PrintInvoice::Config.use_sequential_number?
    return if invoice_number.present?

    update_columns(invoice_number: Spree::PrintInvoice::Config.increase_invoice_number)
  end

  # Returns the invoice date
  #
  def invoice_date
    completed_at
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
    invoice_number.present? ? invoice_number : number
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
  # Prawn templates need to be placed in +app/views/spree/admin/orders/+ folder.
  #
  # Assigns +@order+ instance variable
  #
  def render_pdf(template)
    ActionView::Base.new(
      ActionController::Base.view_paths,
      {order: self}
    ).render(template: "spree/admin/orders/#{template}.pdf.prawn")
  end

  private

  # Sends stored pdf for given template from disk.
  #
  # Renders and stores it if it's not yet present.
  #
  def send_or_create_pdf(template)
    file_path = pdf_file_path(template)

    unless File.exist?(file_path)
      File.open(file_path, "wb") { |f| f.puts render_pdf(template) }
    end

    IO.binread(file_path)
  end
end
