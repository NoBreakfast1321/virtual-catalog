class ProductOptionGroupsController < ApplicationController
  before_action :set_catalog
  before_action :set_product
  before_action :set_product_option_group, only: %i[destroy]
  before_action :build_product_option_group_with_params, only: %i[create]
  before_action :build_product_option_group_without_params, only: %i[new]
  before_action :set_secondary_variants, only: %i[create destroy]

  def new
  end

  def create
    @product_option_group.save!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("create.success")
      end
    end
  end

  def destroy
    @product_option_group.destroy!

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

  def set_product_option_group
    @product_option_group =
      @product.product_option_groups.find(params.expect(:id))
  end

  def build_product_option_group_with_params
    @product_option_group =
      @product.product_option_groups.build(product_option_group_params)
  end

  def build_product_option_group_without_params
    @product_option_group = @product.product_option_groups.build
  end

  def set_secondary_variants
    @secondary_variants = @product.variants.secondary
  end

  # Only allow a list of trusted parameters through.
  def product_option_group_params
    params.expect(product_option_group: [ :option_group_id ])
  end
end
