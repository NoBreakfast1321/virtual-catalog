class ProductPropertyGroupsController < ApplicationController
  before_action :set_business
  before_action :set_product
  before_action :set_product_property_group, only: %i[destroy]

  # GET /businesses/:business_id/products/:product_id/product_property_groups/new
  def new
    @product_property_group = @product.product_property_groups.build
  end

  # POST /businesses/:business_id/products/:product_id/product_property_groups
  def create
    @product_property_group =
      @product.product_property_groups.build(product_property_group_params)

    respond_to do |format|
      if @product_property_group.save
        format.turbo_stream do
          flash.now[:notice] = t_controller("create.success")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/products/:product_id/product_property_groups/:id
  def destroy
    respond_to do |format|
      if @product_property_group.destroy
        format.turbo_stream do
          flash.now[:notice] = t_controller("destroy.success")
        end
      else
        format.turbo_stream do
          flash.now[:alert] = @property.errors.full_messages.to_sentence

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

  def set_product_property_group
    @product_property_group =
      @product.product_property_groups.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def product_property_group_params
    params.expect(product_property_group: [ :property_group_id ])
  end
end
