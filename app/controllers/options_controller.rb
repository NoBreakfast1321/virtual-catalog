class OptionsController < ApplicationController
  before_action :set_business
  before_action :set_option_group
  before_action :set_option, only: %i[edit update destroy]

  # GET /businesses/:business_id/option_groups/:option_group_id/options/new
  def new
    @option = @option_group.options.build
  end

  # GET /businesses/:business_id/option_groups/:option_group_id/options/:id/edit
  def edit
  end

  # POST /businesses/:business_id/option_groups/:option_group_id/options
  def create
    @option = @option_group.options.build(option_params)

    respond_to do |format|
      if @option.save
        format.turbo_stream do
          flash.now[:notice] = t_controller("create.success")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/option_groups/:option_group_id/options/:id
  def update
    respond_to do |format|
      if @option.update(option_params)
        format.turbo_stream do
          flash.now[:notice] = t_controller("update.success")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/option_groups/:option_group_id/options/:id
  def destroy
    respond_to do |format|
      if @option.destroy
        format.turbo_stream do
          flash.now[:notice] = t_controller("destroy.success")
        end
      else
        format.turbo_stream do
          flash.now[:alert] = @option.errors.full_messages.to_sentence

          render turbo_stream: render_toast, status: :unprocessable_entity
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = current_user.businesses.find(params.expect(:business_id))
  end

  def set_option_group
    @option_group =
      @business.option_groups.find(params.expect(:option_group_id))
  end

  def set_option
    @option = @option_group.options.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_params
    params.expect(option: %i[name price visible])
  end
end
