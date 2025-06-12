class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def error(field, klass = "")
    return unless object.errors[field].any?

    @template.content_tag(:div, object.errors.full_messages_for(field).first, class: klass)
  end
end
