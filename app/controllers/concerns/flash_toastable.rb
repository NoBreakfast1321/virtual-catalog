module FlashToastable
  def render_flash_toast
    turbo_stream.prepend :flash_toaster, partial: "layouts/flash_toast"
  end
end
