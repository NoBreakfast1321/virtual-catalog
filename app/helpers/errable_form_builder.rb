class ErrableFormBuilder < ActionView::Helpers::FormBuilder
  def error(field, klass = "")
    return if object.errors[field].empty?

    @template.content_tag(
      :div,
      object.errors.full_messages_for(field).to_sentence,
      class: klass
    )
  end
end
