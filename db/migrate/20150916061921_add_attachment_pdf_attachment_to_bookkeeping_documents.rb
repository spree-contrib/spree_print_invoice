class AddAttachmentPdfAttachmentToBookkeepingDocuments < ActiveRecord::Migration
  def self.up
    change_table :bookkeeping_documents do |t|
      t.attachment :pdf_attachment
    end
  end

  def self.down
    remove_attachment :bookkeeping_documents, :pdf_attachment
  end
end
