class OptionsController < ApplicationController
  before_action :set_catalog
  before_action :set_option_group
  before_action :set_option, only: %i[edit update destroy]
  before_action :build_option_with_params, only: %i[create]
  before_action :build_option_without_params, only: %i[new]

  def new
  end

  def edit
  end

  def create
    @option.save!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("create.success")
      end
    end
  end

  def update
    @option.update!(option_params)

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("update.success")
      end
    end
  end

  def destroy
    @option.destroy!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("destroy.success")
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_option_group
    @option_group =
      @catalog.option_groups.find(params.expect(:option_group_id))
  end

  def set_option
    @option = @option_group.options.find(params.expect(:id))
  end

  def build_option_with_params
    @option = @option_group.options.build(option_params)
  end

  def build_option_without_params
    @option = @option_group.options.build
  end

  # Only allow a list of trusted parameters through.
  def option_params
    params.expect(option: %i[name price visible])
  end
end
