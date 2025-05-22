class OptionsController < ApplicationController
  before_action :set_product, only: %i[ new edit create update destroy ]
  before_action :set_option_group, only: %i[ new edit create update destroy ]
  before_action :set_option, only: %i[ edit update destroy ]

  # GET /products/:product_id/option_groups/:option_group_id/options/new
  def new
    @option = @option_group.options.new
  end

  # GET /products/:product_id/option_groups/:option_group_id/options/:id/edit
  def edit
  end

  # POST /products/:product_id/option_groups/:option_group_id/options
  def create
    @option = @option_group.options.new(option_params)

    respond_to do |format|
      if @option.save
        format.turbo_stream { flash.now[:notice] = "Option was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/:product_id/option_groups/:option_group_id/options/:id
  def update
    respond_to do |format|
      if @option.update(option_params)
        format.turbo_stream { flash.now[:notice] = "Option was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/:product_id/option_groups/:option_group_id/options/:id
  def destroy
    @option.destroy!

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Option was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = current_user.products.find(params.expect(:product_id))
  end

  def set_option_group
    @option_group = @product.option_groups.find(params.expect(:option_group_id))
  end

  def set_option
    @option = @option_group.options.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_params
    params.expect(option: [ :visible, :name, :price_variation ])
  end
end
