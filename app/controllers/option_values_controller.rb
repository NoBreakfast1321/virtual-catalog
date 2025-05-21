class OptionValuesController < ApplicationController
  before_action :set_product, only: %i[ new edit create update destroy ]
  before_action :set_option_type, only: %i[ new edit create update destroy ]
  before_action :set_option_value, only: %i[ edit update destroy ]

  # GET /option_values/new
  def new
    @option_value = @option_type.option_values.new
  end

  # GET /option_values/1/edit
  def edit
  end

  # POST /option_values
  def create
    @option_value = @option_type.option_values.new(option_value_params)

    respond_to do |format|
      if @option_value.save
        format.turbo_stream { flash.now[:notice] = "Option value was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /option_values/1
  def update
    respond_to do |format|
      if @option_value.update(option_value_params)
        format.turbo_stream { flash.now[:notice] = "Option value was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /option_values/1
  def destroy
    @option_value.destroy!

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Option value was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = current_user.products.find(params.expect(:product_id))
  end

  def set_option_type
    @option_type = @product.option_types.find(params.expect(:option_type_id))
  end

  def set_option_value
    @option_value = @option_type.option_values.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_value_params
    params.expect(option_value: [ :visible, :name, :price_variation ])
  end
end
