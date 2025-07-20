class ProductOptionGroupsController < ApplicationController
  before_action :set_business
  before_action :set_product
  before_action :set_product_option_group, only: %i[destroy]

  # GET /businesses/:business_id/products/:product_id/product_option_groups/new
  def new
    @product_option_group = @product.product_option_groups.build
  end

  # POST /businesses/:business_id/products/:product_id/product_option_groups
  def create
    @product_option_group =
      @product.product_option_groups.build(product_option_group_params)

    respond_to do |format|
      if @product_option_group.save
        format.turbo_stream do
          flash.now[:notice] = t_controller("create.success")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/products/:product_id/product_option_groups/:id
  def destroy
    respond_to do |format|
      if @product_option_group.destroy
        format.turbo_stream do
          flash.now[:notice] = t_controller("destroy.success")
        end
      else
        format.turbo_stream do
          flash.now[:alert] = @option.errors.full_messages.to_sentence

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

  def set_product_option_group
    @product_option_group =
      @product.product_option_groups.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def product_option_group_params
    params.expect(product_option_group: [ :option_group_id ])
  end
end
