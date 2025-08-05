class PropertyGroupsController < ApplicationController
  include Pagy::Backend

  before_action :set_business
  before_action :set_property_group, only: %i[show edit update destroy]
  before_action :build_property_group_with_params, only: %i[create]
  before_action :build_property_group_without_params, only: %i[new]
  before_action :set_non_base_variants, only: %i[create destroy]

  def index
    @q = @business.property_groups.ransack(params[:q])
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

      @non_base_variants.each(&:destroy!)
    end

    respond_to do |format|
      format.html do
        redirect_to [ @business, @property_group ],
                    notice: t_controller("create.success")
      end
    end
  end

  def update
    @property_group.update!(property_group_params)

    respond_to do |format|
      format.html do
        redirect_to [ @business, @property_group ],
                    notice: t_controller("update.success")
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @non_base_variants.each(&:destroy!)

      @property_group.destroy!
    end

    respond_to do |format|
      format.html do
        redirect_to business_property_groups_path(@business),
                    notice: t_controller("destroy.success"),
                    status: :see_other
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = current_user.businesses.find(params.expect(:business_id))
  end

  def set_property_group
    @property_group = @business.property_groups.find(params.expect(:id))
  end

  def build_property_group_with_params
    @property_group = @business.property_groups.build(property_group_params)
  end

  def build_property_group_without_params
    @property_group = @business.property_groups.build
  end

  def set_non_base_variants
    @non_base_variants =
      Variant.where(product: @property_group.products).non_base
  end

  # Only allow a list of trusted parameters through.
  def property_group_params
    params.expect(property_group: [ :name ])
  end
end
