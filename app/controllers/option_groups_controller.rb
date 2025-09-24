class OptionGroupsController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog
  before_action :set_option_group, only: %i[show edit update destroy]

  def index
    @q = @catalog.option_groups.includes(:options).ransack(params[:q])
    @pagy, @option_groups = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
    @option_group = @catalog.option_groups.build
  end

  def edit
  end

  def create
    @option_group = @catalog.option_groups.build(option_group_params)

    @option_group.save!

    redirect_to [ @catalog, @option_group ],
                notice: t_controller("create.success")
  end

  def update
    @option_group.update!(option_group_params)

    redirect_to [ @catalog, @option_group ],
                notice: t_controller("update.success")
  end

  def destroy
    @option_group.destroy!

    redirect_to catalog_option_groups_path(@catalog),
                notice: t_controller("destroy.success"),
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_option_group
    @option_group =
      @catalog.option_groups.includes(:options).find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_group_params
    params.expect(
      option_group: %i[name minimum_selections maximum_selections visible],
    )
  end
end
