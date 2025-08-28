# == Route Map
#
#                                     Prefix Verb   URI Pattern                                                                                       Controller#Action
#                                                   /assets                                                                                           Propshaft::Server
#                           new_user_session GET    /users/sign_in(.:format)                                                                          devise/sessions#new
#                               user_session POST   /users/sign_in(.:format)                                                                          devise/sessions#create
#                       destroy_user_session DELETE /users/sign_out(.:format)                                                                         devise/sessions#destroy
#                          new_user_password GET    /users/password/new(.:format)                                                                     devise/passwords#new
#                         edit_user_password GET    /users/password/edit(.:format)                                                                    devise/passwords#edit
#                              user_password PATCH  /users/password(.:format)                                                                         devise/passwords#update
#                                            PUT    /users/password(.:format)                                                                         devise/passwords#update
#                                            POST   /users/password(.:format)                                                                         devise/passwords#create
#                   cancel_user_registration GET    /users/cancel(.:format)                                                                           devise/registrations#cancel
#                      new_user_registration GET    /users/sign_up(.:format)                                                                          devise/registrations#new
#                     edit_user_registration GET    /users/edit(.:format)                                                                             devise/registrations#edit
#                          user_registration PATCH  /users(.:format)                                                                                  devise/registrations#update
#                                            PUT    /users(.:format)                                                                                  devise/registrations#update
#                                            DELETE /users(.:format)                                                                                  devise/registrations#destroy
#                                            POST   /users(.:format)                                                                                  devise/registrations#create
#                         rails_health_check GET    /up(.:format)                                                                                     rails/health#show
#                                       root GET    /                                                                                                 catalogs#index
#                         catalog_categories GET    /catalogs/:catalog_id/categories(.:format)                                                        categories#index
#                                            POST   /catalogs/:catalog_id/categories(.:format)                                                        categories#create
#                       new_catalog_category GET    /catalogs/:catalog_id/categories/new(.:format)                                                    categories#new
#                      edit_catalog_category GET    /catalogs/:catalog_id/categories/:id/edit(.:format)                                               categories#edit
#                           catalog_category GET    /catalogs/:catalog_id/categories/:id(.:format)                                                    categories#show
#                                            PATCH  /catalogs/:catalog_id/categories/:id(.:format)                                                    categories#update
#                                            PUT    /catalogs/:catalog_id/categories/:id(.:format)                                                    categories#update
#                                            DELETE /catalogs/:catalog_id/categories/:id(.:format)                                                    categories#destroy
#                          catalog_customers GET    /catalogs/:catalog_id/customers(.:format)                                                         customers#index
#                                            POST   /catalogs/:catalog_id/customers(.:format)                                                         customers#create
#                       new_catalog_customer GET    /catalogs/:catalog_id/customers/new(.:format)                                                     customers#new
#                      edit_catalog_customer GET    /catalogs/:catalog_id/customers/:id/edit(.:format)                                                customers#edit
#                           catalog_customer GET    /catalogs/:catalog_id/customers/:id(.:format)                                                     customers#show
#                                            PATCH  /catalogs/:catalog_id/customers/:id(.:format)                                                     customers#update
#                                            PUT    /catalogs/:catalog_id/customers/:id(.:format)                                                     customers#update
#                                            DELETE /catalogs/:catalog_id/customers/:id(.:format)                                                     customers#destroy
#               catalog_option_group_options POST   /catalogs/:catalog_id/option_groups/:option_group_id/options(.:format)                            options#create
#            new_catalog_option_group_option GET    /catalogs/:catalog_id/option_groups/:option_group_id/options/new(.:format)                        options#new
#           edit_catalog_option_group_option GET    /catalogs/:catalog_id/option_groups/:option_group_id/options/:id/edit(.:format)                   options#edit
#                catalog_option_group_option PATCH  /catalogs/:catalog_id/option_groups/:option_group_id/options/:id(.:format)                        options#update
#                                            PUT    /catalogs/:catalog_id/option_groups/:option_group_id/options/:id(.:format)                        options#update
#                                            DELETE /catalogs/:catalog_id/option_groups/:option_group_id/options/:id(.:format)                        options#destroy
#                      catalog_option_groups GET    /catalogs/:catalog_id/option_groups(.:format)                                                     option_groups#index
#                                            POST   /catalogs/:catalog_id/option_groups(.:format)                                                     option_groups#create
#                   new_catalog_option_group GET    /catalogs/:catalog_id/option_groups/new(.:format)                                                 option_groups#new
#                  edit_catalog_option_group GET    /catalogs/:catalog_id/option_groups/:id/edit(.:format)                                            option_groups#edit
#                       catalog_option_group GET    /catalogs/:catalog_id/option_groups/:id(.:format)                                                 option_groups#show
#                                            PATCH  /catalogs/:catalog_id/option_groups/:id(.:format)                                                 option_groups#update
#                                            PUT    /catalogs/:catalog_id/option_groups/:id(.:format)                                                 option_groups#update
#                                            DELETE /catalogs/:catalog_id/option_groups/:id(.:format)                                                 option_groups#destroy
#          catalog_property_group_properties POST   /catalogs/:catalog_id/property_groups/:property_group_id/properties(.:format)                     properties#create
#        new_catalog_property_group_property GET    /catalogs/:catalog_id/property_groups/:property_group_id/properties/new(.:format)                 properties#new
#       edit_catalog_property_group_property GET    /catalogs/:catalog_id/property_groups/:property_group_id/properties/:id/edit(.:format)            properties#edit
#            catalog_property_group_property PATCH  /catalogs/:catalog_id/property_groups/:property_group_id/properties/:id(.:format)                 properties#update
#                                            PUT    /catalogs/:catalog_id/property_groups/:property_group_id/properties/:id(.:format)                 properties#update
#                                            DELETE /catalogs/:catalog_id/property_groups/:property_group_id/properties/:id(.:format)                 properties#destroy
#                    catalog_property_groups GET    /catalogs/:catalog_id/property_groups(.:format)                                                   property_groups#index
#                                            POST   /catalogs/:catalog_id/property_groups(.:format)                                                   property_groups#create
#                 new_catalog_property_group GET    /catalogs/:catalog_id/property_groups/new(.:format)                                               property_groups#new
#                edit_catalog_property_group GET    /catalogs/:catalog_id/property_groups/:id/edit(.:format)                                          property_groups#edit
#                     catalog_property_group GET    /catalogs/:catalog_id/property_groups/:id(.:format)                                               property_groups#show
#                                            PATCH  /catalogs/:catalog_id/property_groups/:id(.:format)                                               property_groups#update
#                                            PUT    /catalogs/:catalog_id/property_groups/:id(.:format)                                               property_groups#update
#                                            DELETE /catalogs/:catalog_id/property_groups/:id(.:format)                                               property_groups#destroy
#             catalog_product_product_images PATCH  /catalogs/:catalog_id/products/:product_id/product_images(.:format)                               product_images#update
#                                            PUT    /catalogs/:catalog_id/products/:product_id/product_images(.:format)                               product_images#update
#      catalog_product_product_option_groups POST   /catalogs/:catalog_id/products/:product_id/product_option_groups(.:format)                        product_option_groups#create
#   new_catalog_product_product_option_group GET    /catalogs/:catalog_id/products/:product_id/product_option_groups/new(.:format)                    product_option_groups#new
#       catalog_product_product_option_group DELETE /catalogs/:catalog_id/products/:product_id/product_option_groups/:id(.:format)                    product_option_groups#destroy
#    catalog_product_product_property_groups POST   /catalogs/:catalog_id/products/:product_id/product_property_groups(.:format)                      product_property_groups#create
# new_catalog_product_product_property_group GET    /catalogs/:catalog_id/products/:product_id/product_property_groups/new(.:format)                  product_property_groups#new
#     catalog_product_product_property_group DELETE /catalogs/:catalog_id/products/:product_id/product_property_groups/:id(.:format)                  product_property_groups#destroy
#                   catalog_product_variants POST   /catalogs/:catalog_id/products/:product_id/variants(.:format)                                     variants#create
#                new_catalog_product_variant GET    /catalogs/:catalog_id/products/:product_id/variants/new(.:format)                                 variants#new
#               edit_catalog_product_variant GET    /catalogs/:catalog_id/products/:product_id/variants/:id/edit(.:format)                            variants#edit
#                    catalog_product_variant PATCH  /catalogs/:catalog_id/products/:product_id/variants/:id(.:format)                                 variants#update
#                                            PUT    /catalogs/:catalog_id/products/:product_id/variants/:id(.:format)                                 variants#update
#                                            DELETE /catalogs/:catalog_id/products/:product_id/variants/:id(.:format)                                 variants#destroy
#                           catalog_products GET    /catalogs/:catalog_id/products(.:format)                                                          products#index
#                                            POST   /catalogs/:catalog_id/products(.:format)                                                          products#create
#                        new_catalog_product GET    /catalogs/:catalog_id/products/new(.:format)                                                      products#new
#                       edit_catalog_product GET    /catalogs/:catalog_id/products/:id/edit(.:format)                                                 products#edit
#                            catalog_product GET    /catalogs/:catalog_id/products/:id(.:format)                                                      products#show
#                                            PATCH  /catalogs/:catalog_id/products/:id(.:format)                                                      products#update
#                                            PUT    /catalogs/:catalog_id/products/:id(.:format)                                                      products#update
#                                            DELETE /catalogs/:catalog_id/products/:id(.:format)                                                      products#destroy
#                                   catalogs GET    /catalogs(.:format)                                                                               catalogs#index
#                                            POST   /catalogs(.:format)                                                                               catalogs#create
#                                new_catalog GET    /catalogs/new(.:format)                                                                           catalogs#new
#                               edit_catalog GET    /catalogs/:id/edit(.:format)                                                                      catalogs#edit
#                                    catalog GET    /catalogs/:id(.:format)                                                                           catalogs#show
#                                            PATCH  /catalogs/:id(.:format)                                                                           catalogs#update
#                                            PUT    /catalogs/:id(.:format)                                                                           catalogs#update
#                                            DELETE /catalogs/:id(.:format)                                                                           catalogs#destroy
#                             public_catalog GET    /:slug(.:format)                                                                                  public_catalogs#show
#                             public_product GET    /:catalog_slug/:slug(.:format)                                                                    public_products#show
#           turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#           turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#          turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#              rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#                 rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#              rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#        rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#              rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#               rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#             rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                            POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#          new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#              rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
#   new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#      rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#      rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
#   rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                         rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                   rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                            GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                  rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#            rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                            GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                         rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                  update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                       rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create

Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "catalogs#index"

  resources :catalogs do
    resources :categories
    resources :customers

    resources :option_groups do
      resources :options, except: %i[index show]
    end

    resources :property_groups do
      resources :properties, except: %i[index show]
    end

    resources :products do
      resource :product_images, only: %i[update]

      resources :product_option_groups, only: %i[new create destroy]
      resources :product_property_groups, only: %i[new create destroy]
      resources :variants, except: %i[index show]
    end
  end

  get "/:slug", to: "public_catalogs#show", as: :public_catalog
  get "/:catalog_slug/:slug", to: "public_products#show", as: :public_product
end
