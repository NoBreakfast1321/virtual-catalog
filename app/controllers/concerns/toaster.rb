module Toaster
  def render_toast
    turbo_stream.prepend :toaster, partial: "layouts/toast"
  end
end
