class PropertyGroupsController < ApplicationController
  include Pagy::Backend

  before_action :set_catalog
  before_action :set_property_group, only: %i[show edit update destroy]
  before_action :build_property_group_with_params, only: %i[create]
  before_action :build_property_group_without_params, only: %i[new]
  before_action :set_not_base_variants, only: %i[create destroy]

  def index
    @q = @catalog.property_groups.ransack(params[:q])
    @pagy, @property_groups = pagy(@q.result(distinct: true))
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      @property_group.save!

      @not_base_variants.each(&:destroy!)
    end

    respond_to do |format|
      format.html do
        redirect_to [ @catalog, @property_group ],
                    notice: t_controller("create.success")
      end
    end
  end

  def update
    @property_group.update!(property_group_params)

    respond_to do |format|
      format.html do
        redirect_to [ @catalog, @property_group ],
                    notice: t_controller("update.success")
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @not_base_variants.each(&:destroy!)

      @property_group.destroy!
    end

    respond_to do |format|
      format.html do
        redirect_to catalog_property_groups_path(@catalog),
                    notice: t_controller("destroy.success"),
                    status: :see_other
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = current_user.catalogs.find(params.expect(:catalog_id))
  end

  def set_property_group
    @property_group = @catalog.property_groups.find(params.expect(:id))
  end

  def build_property_group_with_params
    @property_group = @catalog.property_groups.build(property_group_params)
  end

  def build_property_group_without_params
    @property_group = @catalog.property_groups.build
  end

  def set_not_base_variants
    @not_base_variants =
      Variant.where(product: @property_group.products).not_base
  end

  # Only allow a list of trusted parameters through.
  def property_group_params
    params.expect(property_group: [ :name ])
  end
end
