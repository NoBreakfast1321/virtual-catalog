module ErrorHandler
  extend ActiveSupport::Concern

  included { rescue_from StandardError, with: :handle_error }

  private

  def handle_error(exception)
    case exception
    when ActiveRecord::RecordInvalid
      render_validation_error(exception)
    else
      render_general_error(exception)
    end
  end

  def render_validation_error(exception)
    respond_to do |format|
      format.html { render template, status: :unprocessable_content }
    end
  end

  def render_general_error(exception)
    error_message = exception.message.presence || generic_error_message

    respond_to do |format|
      format.html do
        flash.now[:alert] = error_message

        render template, status: :unprocessable_content
      end

      format.turbo_stream do
        flash.now[:alert] = error_message

        render turbo_stream: render_toast, status: :unprocessable_content
      end
    end
  end

  def template
    case action_name
    when "create"
      :new
    when "update"
      :edit
    else
      action_name.to_sym
    end
  end

  def generic_error_message
    I18n.t("errors.messages.internal_server_error")
  end
end
