Spree::Core::Engine.add_routes do
  namespace :admin do
    # Add orders show-route to routes defined in the Spree Core
    # https://github.com/spree/spree/blob/3-0-stable/backend/config/routes.rb#L73
    resources :orders
    resource :print_invoice_settings, only: [:edit, :update]
  end
end
