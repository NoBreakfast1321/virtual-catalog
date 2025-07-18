class VariantsController < ApplicationController
  before_action :set_business
  before_action :set_product
  before_action :set_variant, only: %i[edit update destroy]

  # GET /businesses/:business_id/products/:product_id/variants/new
  def new
    @variant = @product.variants.build
  end

  # GET /businesses/:business_id/products/:product_id/variants/:id/edit
  def edit
  end

  # POST /businesses/:business_id/products/:product_id/variants
  def create
    @variant = @product.variants.build(variant_params)

    respond_to do |format|
      if @variant.save
        format.turbo_stream do
          flash.now[:notice] = t_controller("create.success")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/products/:product_id/variants/:id
  def update
    respond_to do |format|
      if @variant.update(variant_params)
        format.turbo_stream do
          flash.now[:notice] = t_controller("update.success")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/products/:product_id/variants/:id
  def destroy
    respond_to do |format|
      if @variant.destroy
        format.turbo_stream do
          flash.now[:notice] = t_controller("destroy.success")
        end
      else
        format.turbo_stream do
          flash.now[:alert] = @variant.errors.full_messages.to_sentence

          render turbo_stream: render_toast, status: :unprocessable_entity
        end
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

  # Only allow a list of trusted parameters through.
  def variant_params
    params.expect(
      variant: [
        :base,
        :code,
        :price,
        :stock_quantity,
        :visible,
        property_ids: []
      ],
    )
  end
end
