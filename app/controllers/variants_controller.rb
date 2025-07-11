class VariantsController < ApplicationController
  before_action :set_business
  before_action :set_product
  before_action :set_variant, only: %i[ edit update ]

  # GET /businesses/:business_id/products/:product_id/variants/:id/edit
  def edit
  end

  # PATCH/PUT /businesses/:business_id/products/:product_id/variants/:id
  def update
    respond_to do |format|
      if @variant.update(variant_params)
        format.turbo_stream { flash.now[:notice] = "Variant was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
    @variant = @product.variants.non_base.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def variant_params
    params.expect(variant: [ :code, :price, :visible ])
  end
end
