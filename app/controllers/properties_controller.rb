class PropertiesController < ApplicationController
  before_action :set_catalog
  before_action :set_property_group
  before_action :set_property, only: %i[edit update destroy]

  def new
    @property = @property_group.properties.build
  end

  def edit
  end

  def create
    @property = @property_group.properties.build(property_params)

    @property.save!

    flash.now[:notice] = t_controller("create.success")
  end

  def update
    @property.update!(property_params)

    flash.now[:notice] = t_controller("update.success")
  end

  def destroy
    @secondary_variants = @property.variants.secondary

    ActiveRecord::Base.transaction do
      @secondary_variants.each(&:destroy!)

      @property.destroy!
    end

    flash.now[:notice] = t_controller("destroy.success")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_property_group
    @property_group =
      @catalog.property_groups.find(params.expect(:property_group_id))
  end

  def set_property
    @property = @property_group.properties.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params.expect(property: %i[name visible])
  end
end
