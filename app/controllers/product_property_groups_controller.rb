class ProductPropertyGroupsController < ApplicationController
  before_action :set_catalog
  before_action :set_product
  before_action :set_product_property_group, only: %i[destroy]
  before_action :set_secondary_variants, only: %i[create destroy]

  def new
    @product_property_group = @product.product_property_groups.build
  end

  def create
    @product_property_group =
      @product.product_property_groups.build(product_property_group_params)

    ActiveRecord::Base.transaction do
      @secondary_variants.each(&:destroy!)

      @product_property_group.save!
    end

    flash.now[:notice] = t_controller("create.success")
  end

  def destroy
    ActiveRecord::Base.transaction do
      @secondary_variants.each(&:destroy!)

      @product_property_group.destroy!
    end

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

  def set_product_property_group
    @product_property_group =
      @product.product_property_groups.find(params.expect(:id))
  end

  def set_secondary_variants
    @secondary_variants = @product.variants.secondary
  end

  # Only allow a list of trusted parameters through.
  def product_property_group_params
    params.expect(product_property_group: [ :property_group_id ])
  end
end
