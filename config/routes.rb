Spree::Core::Engine.add_routes do
  namespace :admin do
    # https://github.com/spree/spree/blob/3-0-stable/backend/config/routes.rb#L73
    resources :orders do
      resources :bookkeeping_documents, only: :index do
        get 'refresh', on: :collection
      end
    end

    resource :print_invoice_settings, only: [:edit, :update]
    resources :bookkeeping_documents, only: [:index, :show]
  end
end
