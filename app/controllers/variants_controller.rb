class VariantsController < ApplicationController
  before_action :set_business
  before_action :set_product
  before_action :set_variant, only: %i[edit update destroy]
  before_action :set_variant_with_params, only: %i[create]

  def new
    @variant = @product.variants.build
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
  def set_business
    @business = current_user.businesses.find(params.expect(:business_id))
  end

  def set_product
    @product = @business.products.find(params.expect(:product_id))
  end

  def set_variant
    @variant = @product.variants.find(params.expect(:id))
  end

  def set_variant_with_params
    @variant = @product.variants.build(variant_params)
  end

  # Only allow a list of trusted parameters through.
  def variant_params
    params.expect(
      variant: [ :code, :price, :stock_quantity, :visible, property_ids: [] ],
    )
  end
end
