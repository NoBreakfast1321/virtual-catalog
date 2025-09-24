class ProductOptionGroupsController < ApplicationController
  before_action :set_catalog
  before_action :set_product
  before_action :set_product_option_group, only: %i[destroy]

  def new
    @product_option_group = @product.product_option_groups.build
  end

  def create
    @product_option_group =
      @product.product_option_groups.build(product_option_group_params)

    @product_option_group.save!

    flash.now[:notice] = t_controller("create.success")
  end

  def destroy
    @product_option_group.destroy!

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

  def set_product_option_group
    @product_option_group =
      @product.product_option_groups.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def product_option_group_params
    params.expect(product_option_group: [ :option_group_id ])
  end
end
