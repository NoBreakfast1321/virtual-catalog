module ApplicationHelper
  include Pagy::Frontend
  include Toaster

  def custom_form_with(**options, &block)
    options[:builder] = CustomFormBuilder

    form_with(**options, &block)
  end
end
