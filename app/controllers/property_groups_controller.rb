class PropertyGroupsController < ApplicationController
  include Pagy::Backend

  before_action :set_business
  before_action :set_property_group, only: %i[show edit update destroy]
  before_action :set_property_group_with_params, only: %i[create]
  before_action :set_non_base_variants, only: %i[create destroy]

  # GET /businesses/:business_id/property_groups
  def index
    @q = @business.property_groups.ransack(params[:q])
    @pagy, @property_groups = pagy(@q.result(distinct: true))
  end

  # GET /businesses/:business_id/property_groups/:id
  def show
  end

  # GET /businesses/:business_id/property_groups/new
  def new
    @property_group = @business.property_groups.build
  end

  # GET /businesses/:business_id/property_groups/:id/edit
  def edit
  end

  # POST /businesses/:business_id/property_groups
  def create
    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @non_base_variants.find_each(&:destroy!)

          @property_group.save!
        end

        format.html do
          redirect_to [ @business, @property_group ],
                      notice: t_controller("create.success")
        end
      rescue ActiveRecord::RecordInvalid
        format.html { render :new, status: :unprocessable_entity }
      rescue StandardError => error
        format.html do
          flash.now[:alert] = error.message

          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/property_groups/:id
  def update
    respond_to do |format|
      if @property_group.update(property_group_params)
        format.html do
          redirect_to [ @business, @property_group ],
                      notice: t_controller("update.success")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/property_groups/:id
  def destroy
    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @non_base_variants.find_each(&:destroy!)

          @property_group.destroy!
        end

        format.html do
          redirect_to business_property_groups_path(@business),
                      notice: t_controller("destroy.success"),
                      status: :see_other
        end
      rescue StandardError => error
        format.html do
          flash.now[:alert] = error.message

          render :show, status: :unprocessable_entity
        end
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

  def set_property_group_with_params
    @property_group = @business.property_groups.build(property_group_params)
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
