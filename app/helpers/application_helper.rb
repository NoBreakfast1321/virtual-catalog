module ApplicationHelper
  include Pagy::Frontend
  include Toaster

  def errable_form_with(**options, &block)
    options[:builder] = ErrableFormBuilder

    form_with(**options, &block)
  end

  def turbo_frame_id(*records)
    records
      .flatten
      .map do |record|
        record.respond_to?(:to_key) ? dom_id(record) : record.to_s
      end
      .join("_")
  end
end
