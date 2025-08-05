module ErrorHandler
  extend ActiveSupport::Concern

  included { rescue_from StandardError, with: :handle_error }

  private

  def handle_error
    def handle_error(exception)
      case exception
      when ActiveRecord::RecordInvalid
        render_validation_error(exception)
      else
        render_general_error(exception)
      end
    end
  end

  def render_validation_error(exception)
    respond_to do |format|
      format.html { render template, status: :unprocessable_entity }
    end
  end

  def render_general_error(exception)
    respond_to do |format|
      format.html do
        flash.now[:alert] = exception.message

        render template, status: :unprocessable_entity
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
end
