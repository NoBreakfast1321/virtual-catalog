class PropertyGroupsController < ApplicationController
  before_action :set_business
  before_action :set_product
  before_action :set_property_group, only: %i[edit update destroy]

  # GET /businesses/:business_id/products/:product_id/property_groups/new
  def new
    @property_group = @product.property_groups.build
  end

  # GET /businesses/:business_id/products/:product_id/property_groups/:id/edit
  def edit
  end

  # POST /businesses/:business_id/products/:product_id/property_groups
  def create
    @property_group = @product.property_groups.build(property_group_params)

    respond_to do |format|
      if @property_group.save
        format.turbo_stream do
          flash.now[:notice] = t_controller("create.success")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/products/:product_id/property_groups/:id
  def update
    respond_to do |format|
      if @property_group.update(property_group_params)
        format.turbo_stream do
          flash.now[:notice] = t_controller("update.success")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/products/:product_id/property_groups/:id
  def destroy
    respond_to do |format|
      if @property_group.destroy
        format.turbo_stream do
          flash.now[:notice] = t_controller("destroy.success")
        end
      else
        format.turbo_stream do
          flash.now[:alert] = @property_group.errors.full_messages.to_sentence

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

  def set_product
    @product = @business.products.find(params.expect(:product_id))
  end

  def set_property_group
    @property_group = @product.property_groups.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def property_group_params
    params.expect(property_group: [ :name ])
  end
end
