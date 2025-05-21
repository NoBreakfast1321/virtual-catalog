# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                                                 /assets                                                                                           Propshaft::Server
#                         new_user_session GET    /users/sign_in(.:format)                                                                          devise/sessions#new
#                             user_session POST   /users/sign_in(.:format)                                                                          devise/sessions#create
#                     destroy_user_session DELETE /users/sign_out(.:format)                                                                         devise/sessions#destroy
#                        new_user_password GET    /users/password/new(.:format)                                                                     devise/passwords#new
#                       edit_user_password GET    /users/password/edit(.:format)                                                                    devise/passwords#edit
#                            user_password PATCH  /users/password(.:format)                                                                         devise/passwords#update
#                                          PUT    /users/password(.:format)                                                                         devise/passwords#update
#                                          POST   /users/password(.:format)                                                                         devise/passwords#create
#                 cancel_user_registration GET    /users/cancel(.:format)                                                                           devise/registrations#cancel
#                    new_user_registration GET    /users/sign_up(.:format)                                                                          devise/registrations#new
#                   edit_user_registration GET    /users/edit(.:format)                                                                             devise/registrations#edit
#                        user_registration PATCH  /users(.:format)                                                                                  devise/registrations#update
#                                          PUT    /users(.:format)                                                                                  devise/registrations#update
#                                          DELETE /users(.:format)                                                                                  devise/registrations#destroy
#                                          POST   /users(.:format)                                                                                  devise/registrations#create
#                       rails_health_check GET    /up(.:format)                                                                                     rails/health#show
#                                     root GET    /                                                                                                 products#index
#                               categories GET    /categories(.:format)                                                                             categories#index
#                                          POST   /categories(.:format)                                                                             categories#create
#                             new_category GET    /categories/new(.:format)                                                                         categories#new
#                            edit_category GET    /categories/:id/edit(.:format)                                                                    categories#edit
#                                 category GET    /categories/:id(.:format)                                                                         categories#show
#                                          PATCH  /categories/:id(.:format)                                                                         categories#update
#                                          PUT    /categories/:id(.:format)                                                                         categories#update
#                                          DELETE /categories/:id(.:format)                                                                         categories#destroy
#        product_option_type_option_values GET    /products/:product_id/option_types/:option_type_id/option_values(.:format)                        option_values#index
#                                          POST   /products/:product_id/option_types/:option_type_id/option_values(.:format)                        option_values#create
#     new_product_option_type_option_value GET    /products/:product_id/option_types/:option_type_id/option_values/new(.:format)                    option_values#new
#    edit_product_option_type_option_value GET    /products/:product_id/option_types/:option_type_id/option_values/:id/edit(.:format)               option_values#edit
#         product_option_type_option_value GET    /products/:product_id/option_types/:option_type_id/option_values/:id(.:format)                    option_values#show
#                                          PATCH  /products/:product_id/option_types/:option_type_id/option_values/:id(.:format)                    option_values#update
#                                          PUT    /products/:product_id/option_types/:option_type_id/option_values/:id(.:format)                    option_values#update
#                                          DELETE /products/:product_id/option_types/:option_type_id/option_values/:id(.:format)                    option_values#destroy
#                     product_option_types GET    /products/:product_id/option_types(.:format)                                                      option_types#index
#                                          POST   /products/:product_id/option_types(.:format)                                                      option_types#create
#                  new_product_option_type GET    /products/:product_id/option_types/new(.:format)                                                  option_types#new
#                 edit_product_option_type GET    /products/:product_id/option_types/:id/edit(.:format)                                             option_types#edit
#                      product_option_type GET    /products/:product_id/option_types/:id(.:format)                                                  option_types#show
#                                          PATCH  /products/:product_id/option_types/:id(.:format)                                                  option_types#update
#                                          PUT    /products/:product_id/option_types/:id(.:format)                                                  option_types#update
#                                          DELETE /products/:product_id/option_types/:id(.:format)                                                  option_types#destroy
#                                 products GET    /products(.:format)                                                                               products#index
#                                          POST   /products(.:format)                                                                               products#create
#                              new_product GET    /products/new(.:format)                                                                           products#new
#                             edit_product GET    /products/:id/edit(.:format)                                                                      products#edit
#                                  product GET    /products/:id(.:format)                                                                           products#show
#                                          PATCH  /products/:id(.:format)                                                                           products#update
#                                          PUT    /products/:id(.:format)                                                                           products#update
#                                          DELETE /products/:id(.:format)                                                                           products#destroy
#         turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
#         turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
#        turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create

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
  root "products#index"

  resources :categories
  resources :products do
    resources :option_types do
      resources :option_values
    end
  end
end
