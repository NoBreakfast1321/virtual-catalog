class ApplicationController < ActionController::Base
  include Toaster

  before_action :authenticate_user!, unless: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
