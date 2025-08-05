class PropertiesController < ApplicationController
  before_action :set_business
  before_action :set_property_group
  before_action :set_property, only: %i[edit update destroy]
  before_action :set_property_with_params, only: %i[create]
  before_action :set_non_base_variants, only: %i[destroy]

  # GET /businesses/:business_id/property_groups/:property_group_id/properties/new
  def new
    @property = @property_group.properties.build
  end

  # GET /businesses/:business_id/property_groups/:property_group_id/properties/:id/edit
  def edit
  end

  # POST /businesses/:business_id/property_groups/:property_group_id/properties
  def create
    @property = @property_group.properties.build(property_params)

    respond_to do |format|
      if @property.save
        format.turbo_stream do
          flash.now[:notice] = t_controller("create.success")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/property_groups/:property_group_id/properties/:id
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.turbo_stream do
          flash.now[:notice] = t_controller("update.success")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/property_groups/:property_group_id/properties/:id
  def destroy
    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @non_base_variants.find_each(&:destroy!)

          @property.destroy!
        end

        format.turbo_stream do
          flash.now[:notice] = t_controller("destroy.success")
        end
      rescue StandardError => error
        format.turbo_stream do
          flash.now[:alert] = error.message

          render turbo_stream: render_toast, status: :unprocessable_entity
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
    @property_group =
      @business.property_groups.find(params.expect(:property_group_id))
  end

  def set_property
    @property = @property_group.properties.find(params.expect(:id))
  end

  def set_property_with_params
    @property = @property_group.properties.build(property_params)
  end

  def set_non_base_variants
    @non_base_variants = @property.variants.non_base
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params.expect(property: %i[name visible])
  end
end
