module Toaster
  def render_toast
    turbo_stream.prepend turbo_frame_id(:toaster), partial: "layouts/toast"
  end
end
