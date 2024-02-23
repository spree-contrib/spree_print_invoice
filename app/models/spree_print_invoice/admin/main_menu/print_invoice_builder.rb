module SpreePrintInvoice
  module Admin
    module MainMenu
      class PrintInvoiceBuilder
        include ::Spree::Core::Engine.routes.url_helpers

        def build
          items = [
            ::Spree::Admin::MainMenu::ItemBuilder.new('invoices', ::Spree::Core::Engine.routes.url_helpers.admin_bookkeeping_documents_path(q: { template_eq: 'invoice' })).
              with_label_translation_key('admin.invoices').
              with_manage_ability_check(::Spree::BookkeepingDocument).
              with_match_path('/bookkeeping_documents?q%5Btemplate_eq%5D=invoice').
              build,
            ::Spree::Admin::MainMenu::ItemBuilder.new('packaging_slips', ::Spree::Core::Engine.routes.url_helpers.admin_bookkeeping_documents_path(q: { template_eq: 'packaging_slip' })).
              with_label_translation_key('admin.packaging_slips').
              with_manage_ability_check(::Spree::BookkeepingDocument).
              with_match_path('/bookkeeping_documents?q%5Btemplate_eq%5D=packaging_slip').
              build
          ]

          ::Spree::Admin::MainMenu::SectionBuilder.new('documents', 'file.svg').
              with_manage_ability_check(::Spree::BookkeepingDocument).
              with_label_translation_key('admin.documents').
              with_items(items).
              build
        end
      end
    end
  end
end
