module ApplicationHelper
  include Pagy::Frontend
  include Toaster

  def custom_form_with(**options, &block)
    options[:builder] = CustomFormBuilder

    form_with(**options, &block)
  end

  def turbo_frame_id(*records)
    records.flatten.map { |record| record.respond_to?(:to_key) ? dom_id(record) : record.to_s }.join("_")
  end
end
