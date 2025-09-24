class OptionsController < ApplicationController
  before_action :set_catalog
  before_action :set_option_group
  before_action :set_option, only: %i[edit update destroy]

  def new
    @option = @option_group.options.build
  end

  def edit
  end

  def create
    @option = @option_group.options.build(option_params)

    @option.save!

    flash.now[:notice] = t_controller("create.success")
  end

  def update
    @option.update!(option_params)

    flash.now[:notice] = t_controller("update.success")
  end

  def destroy
    @option.destroy!

    flash.now[:notice] = t_controller("destroy.success")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_option_group
    @option_group = @catalog.option_groups.find(params.expect(:option_group_id))
  end

  def set_option
    @option = @option_group.options.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_params
    params.expect(option: %i[name price visible])
  end
end
