class VariantsController < ApplicationController
  before_action :set_catalog
  before_action :set_product
  before_action :set_variant, only: %i[edit update destroy]

  def new
    @variant = @product.variants.build
  end

  def edit
  end

  def create
    @variant = @product.variants.build(variant_params)

    @variant.save!

    flash.now[:notice] = t_controller("create.success")
  end

  def update
    @variant.update!(variant_params)

    flash.now[:notice] = t_controller("update.success")
  end

  def destroy
    @variant.destroy!

    flash.now[:notice] = t_controller("destroy.success")
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

  # Only allow a list of trusted parameters through.
  def variant_params
    params.expect(
      variant: [ :code, :price, :stock_quantity, :visible, property_ids: [] ],
    )
  end
end
