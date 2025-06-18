class ApplicationController < ActionController::Base
  include Toaster

  before_action :authenticate_user!, unless: :devise_controller?

  before_action :ensure_onboarding_complete

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_business
    @current_business = current_user&.business
  end

  def onboarding_business_step?
    controller_name == "businesses" && action_name.in?(%w[ new create ])
  end

  def onboarding_category_step?
    controller_name == "categories" && action_name.in?(%w[ new create ])
  end

  def ensure_onboarding_complete
    return if devise_controller?

    if current_business.nil?
      return if onboarding_business_step?

      redirect_to new_business_path
    elsif current_business.categories.empty?
      return if onboarding_category_step?

      redirect_to new_category_path
    end
  end

  helper_method :current_business
end
