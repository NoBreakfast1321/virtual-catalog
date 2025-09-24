class CatalogsController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog, only: %i[show edit update destroy]

  def index
    @q = current_user.catalogs.ransack(params[:q])
    @pagy, @catalogs = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
    @catalog = current_user.catalogs.build
  end

  def edit
  end

  def create
    @catalog = current_user.catalogs.build(catalog_params)

    @catalog.save!

    redirect_to @catalog, notice: t_controller("create.success")
  end

  def update
    @catalog.update!(catalog_params)

    redirect_to @catalog, notice: t_controller("update.success")
  end

  def destroy
    @catalog.destroy!

    redirect_to catalogs_path,
                notice: t_controller("destroy.success"),
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def catalog_params
    params.expect(catalog: %i[name slug description visible])
  end
end
