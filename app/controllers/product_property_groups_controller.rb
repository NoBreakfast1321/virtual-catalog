class ProductPropertyGroupsController < ApplicationController
  before_action :set_catalog
  before_action :set_product
  before_action :set_product_property_group, only: %i[destroy]
  before_action :build_product_property_group_with_params, only: %i[create]
  before_action :build_product_property_group_without_params, only: %i[new]
  before_action :set_secondary_variants, only: %i[create destroy]

  def new
  end

  def create
    ActiveRecord::Base.transaction do
      @secondary_variants.each(&:destroy!)

      @product_property_group.save!
    end

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("create.success")
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @secondary_variants.each(&:destroy!)

      @product_property_group.destroy!
    end

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

  def set_product_property_group
    @product_property_group =
      @product.product_property_groups.find(params.expect(:id))
  end

  def build_product_property_group_with_params
    @product_property_group =
      @product.product_property_groups.build(product_property_group_params)
  end

  def build_product_property_group_without_params
    @product_property_group = @product.product_property_groups.build
  end

  def set_secondary_variants
    @secondary_variants = @product.variants.secondary
  end

  # Only allow a list of trusted parameters through.
  def product_property_group_params
    params.expect(product_property_group: [ :property_group_id ])
  end
end
