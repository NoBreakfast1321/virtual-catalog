class ApplicationController < ActionController::Base
  include ErrorHandler
  include Toaster

  before_action :authenticate_user!, unless: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def audit_comment
    "#{controller_name}##{action_name}"
  end

  def t_controller(key)
    t("controllers.#{controller_name}.#{key}")
  end
end
