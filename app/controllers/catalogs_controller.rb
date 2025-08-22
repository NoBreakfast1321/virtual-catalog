class CatalogsController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog, only: %i[show edit update destroy]
  before_action :build_catalog_with_params, only: %i[create]
  before_action :build_catalog_without_params, only: %i[new]

  def index
    @q = current_user.catalogs.ransack(params[:q])
    @pagy, @catalogs = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @catalog.save!

    respond_to do |format|
      format.html do
        redirect_to @catalog, notice: t_controller("create.success")
      end
    end
  end

  def update
    @catalog.update!(catalog_params)

    respond_to do |format|
      format.html do
        redirect_to @catalog, notice: t_controller("update.success")
      end
    end
  end

  def destroy
    @catalog.destroy!

    respond_to do |format|
      format.html do
        redirect_to catalogs_path,
                    notice: t_controller("destroy.success"),
                    status: :see_other
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:id))
  end

  def build_catalog_with_params
    @catalog = current_user.catalogs.build(catalog_params)
  end

  def build_catalog_without_params
    @catalog = current_user.catalogs.build
  end

  # Only allow a list of trusted parameters through.
  def catalog_params
    params.expect(catalog: %i[name slug description visible])
  end
end
