class PropertiesController < ApplicationController
  before_action :set_catalog
  before_action :set_property_group
  before_action :set_property, only: %i[edit update destroy]
  before_action :build_property_with_params, only: %i[create]
  before_action :build_property_without_params, only: %i[new]
  before_action :set_secondary_variants, only: %i[destroy]

  def new
  end

  def edit
  end

  def create
    @property.save!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("create.success")
      end
    end
  end

  def update
    @property.update!(property_params)

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = t_controller("update.success")
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @secondary_variants.each(&:destroy!)

      @property.destroy!
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

  def set_property_group
    @property_group =
      @catalog.property_groups.find(params.expect(:property_group_id))
  end

  def set_property
    @property = @property_group.properties.find(params.expect(:id))
  end

  def build_property_with_params
    @property = @property_group.properties.build(property_params)
  end

  def build_property_without_params
    @property = @property_group.properties.build
  end

  def set_secondary_variants
    @secondary_variants = @property.variants.secondary
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params.expect(property: %i[name visible])
  end
end
