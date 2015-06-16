Spree::Reimbursement.class_eval do
  has_many :bookkeeping_documents, as: :printable
  has_one :invoice, -> { where(template: 'invoice') },
          class_name: 'Spree::BookkeepingDocument',
          as: :printable

  before_create :invoice_for_reimbursement

  private

  def invoice_for_reimbursement
    bookkeeping_documents.build(template: 'invoice')
  end
end
