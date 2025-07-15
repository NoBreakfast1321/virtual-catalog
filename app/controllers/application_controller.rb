class ApplicationController < ActionController::Base
  include Toaster

  before_action :authenticate_user!, unless: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def audit_comment
    "#{controller_name}##{action_name}"
  end

  def set_audit_comment
    resource = instance_variable_get("@#{controller_name.singularize}")

    resource.audit_comment = audit_comment if resource&.respond_to?(:audit_comment=)
  end
end
