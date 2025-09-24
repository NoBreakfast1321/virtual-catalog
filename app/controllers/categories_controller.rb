class CategoriesController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @q = @catalog.categories.ransack(params[:q])
    @pagy, @categories = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
    @category = @catalog.categories.build
  end

  def edit
  end

  def create
    @category = @catalog.categories.build(category_params)

    @category.save!

    redirect_to [ @catalog, @category ], notice: t_controller("create.success")
  end

  def update
    @category.update!(category_params)

    redirect_to [ @catalog, @category ], notice: t_controller("update.success")
  end

  def destroy
    @category.destroy!

    redirect_to catalog_categories_path(@catalog),
                notice: t_controller("destroy.success"),
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_category
    @category = @catalog.categories.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.expect(category: %i[name description visible])
  end
end
