class VariantsController < ApplicationController
  before_action :set_catalog
  before_action :set_product
  before_action :set_variant, only: %i[edit update destroy]
  before_action :build_variant_with_params, only: %i[create]
  before_action :build_variant_without_params, only: %i[new]

  def new
  end

  def edit
  end

  def create
    @variant.save!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("create.success")
      end
    end
  end

  def update
    @variant.update!(variant_params)

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("update.success")
      end
    end
  end

  def destroy
    @variant.destroy!

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

  def set_product
    @product = @catalog.products.find(params.expect(:product_id))
  end

  def set_variant
    @variant = @product.variants.find(params.expect(:id))
  end

  def build_variant_with_params
    @variant = @product.variants.build(variant_params)
  end

  def build_variant_without_params
    @variant = @product.variants.build
  end

  # Only allow a list of trusted parameters through.
  def variant_params
    params.expect(
      variant: [ :code, :price, :stock_quantity, :visible, property_ids: [] ],
    )
  end
end
