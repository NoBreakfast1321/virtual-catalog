class OptionTypesController < ApplicationController
  before_action :set_product, only: %i[ new edit create update destroy ]
  before_action :set_option_type, only: %i[ edit update destroy ]

  # GET /option_types/new
  def new
    @option_type = @product.option_types.new
  end

  # GET /option_types/1/edit
  def edit
  end

  # POST /option_types
  def create
    @option_type = @product.option_types.new(option_type_params)

    respond_to do |format|
      if @option_type.save
        format.turbo_stream { flash.now[:notice] = "Option type was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /option_types/1
  def update
    respond_to do |format|
      if @option_type.update(option_type_params)
        format.turbo_stream { flash.now[:notice] = "Option type was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /option_types/1
  def destroy
    @option_type.destroy!

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Option type was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = current_user.products.find(params.expect(:product_id))
  end

  def set_option_type
    @option_type = @product.option_types.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_type_params
    params.expect(option_type: [ :visible, :name, :min_choices, :max_choices ])
  end
end
