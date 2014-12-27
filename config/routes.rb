Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :orders do
      member do
        get :show
      end
    end
    resource :print_invoice_settings, only: [:edit, :update]
  end
end
