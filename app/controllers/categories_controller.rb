class CategoriesController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog
  before_action :set_category, only: %i[show edit update destroy]
  before_action :build_category_with_params, only: %i[create]
  before_action :build_category_without_params, only: %i[new]

  def index
    @q = @catalog.categories.ransack(params[:q])
    @pagy, @categories = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @category.save!

    respond_to do |format|
      format.html do
        redirect_to [ @catalog, @category ],
                    notice: t_controller("create.success")
      end
    end
  end

  def update
    @category.update!(category_params)

    respond_to do |format|
      format.html do
        redirect_to [ @catalog, @category ],
                    notice: t_controller("update.success")
      end
    end
  end

  def destroy
    @category.destroy!

    respond_to do |format|
      format.html do
        redirect_to catalog_categories_path(@catalog),
                    notice: t_controller("destroy.success"),
                    status: :see_other
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_category
    @category = @catalog.categories.find(params.expect(:id))
  end

  def build_category_with_params
    @category = @catalog.categories.build(category_params)
  end

  def build_category_without_params
    @category = @catalog.categories.build
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.expect(category: %i[name description visible])
  end
end
