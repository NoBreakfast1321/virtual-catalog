class PropertyGroupsController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog
  before_action :set_property_group, only: %i[show edit update destroy]
  before_action :set_secondary_variants, only: %i[create destroy]

  def index
    @q = @catalog.property_groups.includes(:properties).ransack(params[:q])
    @pagy, @property_groups = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
    @property_group = @catalog.property_groups.build
  end

  def edit
  end

  def create
    @property_group = @catalog.property_groups.build(property_group_params)

    ActiveRecord::Base.transaction do
      @property_group.save!

      @secondary_variants.each(&:destroy!)
    end

    redirect_to [ @catalog, @property_group ],
                notice: t_controller("create.success")
  end

  def update
    @property_group.update!(property_group_params)

    redirect_to [ @catalog, @property_group ],
                notice: t_controller("update.success")
  end

  def destroy
    ActiveRecord::Base.transaction do
      @secondary_variants.each(&:destroy!)

      @property_group.destroy!
    end

    redirect_to catalog_property_groups_path(@catalog),
                notice: t_controller("destroy.success"),
                status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_property_group
    @property_group =
      @catalog.property_groups.includes(:properties).find(params.expect(:id))
  end

  def set_secondary_variants
    @secondary_variants =
      if @property_group.products.any?
        Variant.where(product: @property_group.products).secondary
      else
        Variant.none
      end
  end

  # Only allow a list of trusted parameters through.
  def property_group_params
    params.expect(property_group: %i[name])
  end
end
