class ProductsController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog
  before_action :set_product, only: %i[show edit update destroy]

  before_action :restrict_product_creation,
                only: %i[new create],
                if: -> { @catalog.categories.empty? }

  def index
    @q = @catalog.products.includes(:categories).ransack(params[:q])
    @pagy, @products = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
    @product = @catalog.products.build
  end

  def edit
  end

  def create
    @product = @catalog.products.build(product_params)

    ActiveRecord::Base.transaction do
      @product.save!

      @product.variants.create!(**variant_params, primary: true)
    end

    redirect_to [ @catalog, @product ], notice: t_controller("create.success")
  end

  def update
    ActiveRecord::Base.transaction do
      @product.update!(product_params)

      @product.primary_variant.update!(variant_params)
    end

    redirect_to [ @catalog, @product ], notice: t_controller("update.success")
  end

  def destroy
    @product.destroy!

    redirect_to catalog_products_path(@catalog),
                notice: t_controller("destroy.success"),
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_product
    @product =
      @catalog
        .products
        .includes(
          :categories,
          product_option_groups: :option_group,
          product_property_groups: :property_group,
          variants: :property_groups,
        )
        .find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.expect(
      product: [
        :name,
        :code,
        :description,
        :adult_only,
        :featured,
        :visible,
        :available_from,
        :available_until,
        category_ids: []
      ],
    )
  end

  def variant_params
    params.expect(:product).slice(:code, :price, :visible)
  end

  # Use callbacks for constraints and restrictions.
  def restrict_product_creation
    redirect_to new_catalog_category_path(@catalog),
                alert: t_controller("callbacks.restrict_product_creation")
  end
end
