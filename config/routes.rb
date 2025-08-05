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
#                                       root GET    /                                                                                                 businesses#index
#                        business_categories GET    /businesses/:business_id/categories(.:format)                                                     categories#index
#                                            POST   /businesses/:business_id/categories(.:format)                                                     categories#create
#                      new_business_category GET    /businesses/:business_id/categories/new(.:format)                                                 categories#new
#                     edit_business_category GET    /businesses/:business_id/categories/:id/edit(.:format)                                            categories#edit
#                          business_category GET    /businesses/:business_id/categories/:id(.:format)                                                 categories#show
#                                            PATCH  /businesses/:business_id/categories/:id(.:format)                                                 categories#update
#                                            PUT    /businesses/:business_id/categories/:id(.:format)                                                 categories#update
#                                            DELETE /businesses/:business_id/categories/:id(.:format)                                                 categories#destroy
#              business_option_group_options GET    /businesses/:business_id/option_groups/:option_group_id/options(.:format)                         options#index
#                                            POST   /businesses/:business_id/option_groups/:option_group_id/options(.:format)                         options#create
#           new_business_option_group_option GET    /businesses/:business_id/option_groups/:option_group_id/options/new(.:format)                     options#new
#          edit_business_option_group_option GET    /businesses/:business_id/option_groups/:option_group_id/options/:id/edit(.:format)                options#edit
#               business_option_group_option GET    /businesses/:business_id/option_groups/:option_group_id/options/:id(.:format)                     options#show
#                                            PATCH  /businesses/:business_id/option_groups/:option_group_id/options/:id(.:format)                     options#update
#                                            PUT    /businesses/:business_id/option_groups/:option_group_id/options/:id(.:format)                     options#update
#                                            DELETE /businesses/:business_id/option_groups/:option_group_id/options/:id(.:format)                     options#destroy
#                     business_option_groups GET    /businesses/:business_id/option_groups(.:format)                                                  option_groups#index
#                                            POST   /businesses/:business_id/option_groups(.:format)                                                  option_groups#create
#                  new_business_option_group GET    /businesses/:business_id/option_groups/new(.:format)                                              option_groups#new
#                 edit_business_option_group GET    /businesses/:business_id/option_groups/:id/edit(.:format)                                         option_groups#edit
#                      business_option_group GET    /businesses/:business_id/option_groups/:id(.:format)                                              option_groups#show
#                                            PATCH  /businesses/:business_id/option_groups/:id(.:format)                                              option_groups#update
#                                            PUT    /businesses/:business_id/option_groups/:id(.:format)                                              option_groups#update
#                                            DELETE /businesses/:business_id/option_groups/:id(.:format)                                              option_groups#destroy
#         business_property_group_properties GET    /businesses/:business_id/property_groups/:property_group_id/properties(.:format)                  properties#index
#                                            POST   /businesses/:business_id/property_groups/:property_group_id/properties(.:format)                  properties#create
#       new_business_property_group_property GET    /businesses/:business_id/property_groups/:property_group_id/properties/new(.:format)              properties#new
#      edit_business_property_group_property GET    /businesses/:business_id/property_groups/:property_group_id/properties/:id/edit(.:format)         properties#edit
#           business_property_group_property GET    /businesses/:business_id/property_groups/:property_group_id/properties/:id(.:format)              properties#show
#                                            PATCH  /businesses/:business_id/property_groups/:property_group_id/properties/:id(.:format)              properties#update
#                                            PUT    /businesses/:business_id/property_groups/:property_group_id/properties/:id(.:format)              properties#update
#                                            DELETE /businesses/:business_id/property_groups/:property_group_id/properties/:id(.:format)              properties#destroy
#                   business_property_groups GET    /businesses/:business_id/property_groups(.:format)                                                property_groups#index
#                                            POST   /businesses/:business_id/property_groups(.:format)                                                property_groups#create
#                new_business_property_group GET    /businesses/:business_id/property_groups/new(.:format)                                            property_groups#new
#               edit_business_property_group GET    /businesses/:business_id/property_groups/:id/edit(.:format)                                       property_groups#edit
#                    business_property_group GET    /businesses/:business_id/property_groups/:id(.:format)                                            property_groups#show
#                                            PATCH  /businesses/:business_id/property_groups/:id(.:format)                                            property_groups#update
#                                            PUT    /businesses/:business_id/property_groups/:id(.:format)                                            property_groups#update
#                                            DELETE /businesses/:business_id/property_groups/:id(.:format)                                            property_groups#destroy
#     business_product_product_option_groups GET    /businesses/:business_id/products/:product_id/product_option_groups(.:format)                     product_option_groups#index
#                                            POST   /businesses/:business_id/products/:product_id/product_option_groups(.:format)                     product_option_groups#create
#  new_business_product_product_option_group GET    /businesses/:business_id/products/:product_id/product_option_groups/new(.:format)                 product_option_groups#new
# edit_business_product_product_option_group GET    /businesses/:business_id/products/:product_id/product_option_groups/:id/edit(.:format)            product_option_groups#edit
#      business_product_product_option_group GET    /businesses/:business_id/products/:product_id/product_option_groups/:id(.:format)                 product_option_groups#show
#                                            PATCH  /businesses/:business_id/products/:product_id/product_option_groups/:id(.:format)                 product_option_groups#update
#                                            PUT    /businesses/:business_id/products/:product_id/product_option_groups/:id(.:format)                 product_option_groups#update
#                                            DELETE /businesses/:business_id/products/:product_id/product_option_groups/:id(.:format)                 product_option_groups#destroy
#                  business_product_variants GET    /businesses/:business_id/products/:product_id/variants(.:format)                                  variants#index
#                                            POST   /businesses/:business_id/products/:product_id/variants(.:format)                                  variants#create
#               new_business_product_variant GET    /businesses/:business_id/products/:product_id/variants/new(.:format)                              variants#new
#              edit_business_product_variant GET    /businesses/:business_id/products/:product_id/variants/:id/edit(.:format)                         variants#edit
#                   business_product_variant GET    /businesses/:business_id/products/:product_id/variants/:id(.:format)                              variants#show
#                                            PATCH  /businesses/:business_id/products/:product_id/variants/:id(.:format)                              variants#update
#                                            PUT    /businesses/:business_id/products/:product_id/variants/:id(.:format)                              variants#update
#                                            DELETE /businesses/:business_id/products/:product_id/variants/:id(.:format)                              variants#destroy
#                          business_products GET    /businesses/:business_id/products(.:format)                                                       products#index
#                                            POST   /businesses/:business_id/products(.:format)                                                       products#create
#                       new_business_product GET    /businesses/:business_id/products/new(.:format)                                                   products#new
#                      edit_business_product GET    /businesses/:business_id/products/:id/edit(.:format)                                              products#edit
#                           business_product GET    /businesses/:business_id/products/:id(.:format)                                                   products#show
#                                            PATCH  /businesses/:business_id/products/:id(.:format)                                                   products#update
#                                            PUT    /businesses/:business_id/products/:id(.:format)                                                   products#update
#                                            DELETE /businesses/:business_id/products/:id(.:format)                                                   products#destroy
#                                 businesses GET    /businesses(.:format)                                                                             businesses#index
#                                            POST   /businesses(.:format)                                                                             businesses#create
#                               new_business GET    /businesses/new(.:format)                                                                         businesses#new
#                              edit_business GET    /businesses/:id/edit(.:format)                                                                    businesses#edit
#                                   business GET    /businesses/:id(.:format)                                                                         businesses#show
#                                            PATCH  /businesses/:id(.:format)                                                                         businesses#update
#                                            PUT    /businesses/:id(.:format)                                                                         businesses#update
#                                            DELETE /businesses/:id(.:format)                                                                         businesses#destroy
#                                    catalog GET    /:slug(.:format)                                                                                  catalogs#show
#                             public_product GET    /:business_slug/:slug(.:format)                                                                   public_products#show
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
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "businesses#index"

  resources :businesses do
    resources :categories

    resources :option_groups do
      resources :options, except: %i[index show]
    end

    resources :property_groups do
      resources :properties, except: %i[index show]
    end

    resources :products do
      resources :product_option_groups
      resources :product_property_groups
      resources :variants, except: %i[index show]
    end
  end

  get "/:slug", to: "catalogs#show", as: :catalog
  get "/:business_slug/:slug", to: "public_products#show", as: :public_product
end
