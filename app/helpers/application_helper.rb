module ApplicationHelper
  include Pagy::Frontend

  def render_flash_toast
    turbo_stream.prepend :flash_toaster, partial: "layouts/flash_toast"
  end
end
