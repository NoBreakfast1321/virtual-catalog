class ApplicationController < ActionController::Base
  include FlashToastable

  before_action :authenticate_user!, unless: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_business
    @current_business = current_user&.business
  end

  helper_method :current_business
end
