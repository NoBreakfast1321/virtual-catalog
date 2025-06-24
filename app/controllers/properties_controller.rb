class PropertiesController < ApplicationController
  before_action :set_product
  before_action :set_property_group
  before_action :set_property, only: %i[ edit update destroy ]

  # GET /products/:product_id/property_groups/:property_group_id/properties/new
  def new
    @property = @property_group.properties.build
  end

  # GET /products/:product_id/property_groups/:property_group_id/properties/:id/edit
  def edit
  end

  # POST /products/:product_id/property_groups/:property_group_id/properties
  def create
    @property = @property_group.properties.build(property_params)

    respond_to do |format|
      if @property.save
        Products::VariantsRebuilder.call(@product)

        format.turbo_stream { flash.now[:notice] = "Property was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/:product_id/property_groups/:property_group_id/properties/:id
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.turbo_stream { flash.now[:notice] = "Property was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/:product_id/property_groups/:property_group_id/properties/:id
  def destroy
    respond_to do |format|
      if @property.destroy
        Products::VariantsRebuilder.call(@product)

        format.turbo_stream { flash.now[:notice] = "Property was successfully destroyed." }
      else
        format.turbo_stream do
          flash.now[:alert] = @property.errors.full_messages.to_sentence

          render turbo_stream: render_toast, status: :unprocessable_entity
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = current_business.products.find(params.expect(:product_id))
  end

  def set_property_group
    @property_group = @product.property_groups.find(params.expect(:property_group_id))
  end

  def set_property
    @property = @property_group.properties.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params.expect(property: [ :name, :price_variation, :visible ])
  end
end
