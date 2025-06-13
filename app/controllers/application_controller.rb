class ApplicationController < ActionController::Base
  include Toaster

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :ensure_business_creation
  before_action :ensure_category_creation

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_business
    @current_business = current_user&.business
  end

  def ensure_business_creation
    # Avoid blocking Devise so the user can still sign out.
    return if devise_controller?

    # Allow access to businesses#new and #create to avoid redirect loop.
    return if controller_name == "businesses" && action_name.in?(%w[new create])

    if current_business.nil?
      redirect_to new_business_path, alert: "You must create your business before accessing the app."
    end
  end

  def ensure_category_creation
    # Avoid blocking Devise so the user can still sign out.
    return if devise_controller?

    # Allow access to categories#new and #create to avoid redirect loop.
    return if controller_name == "categories" && action_name.in?(%w[new create])

    # Prevent category check before business creation to avoid redirect loop.
    return if current_business.nil?

    if current_business.categories.blank?
      redirect_to new_category_path, alert: "You must create at least one category before accessing the app."
    end
  end

  helper_method :current_business
end
