class OptionsController < ApplicationController
  before_action :set_business
  before_action :set_product
  before_action :set_option_group
  before_action :build_option_with_params, only: %i[ create ]
  before_action :set_option, only: %i[ edit update destroy ]

  before_action :set_audit_comment, only: %i[ create update destroy ]

  # GET /businesses/:business_id/products/:product_id/option_groups/:option_group_id/options/new
  def new
    @option = @option_group.options.build
  end

  # GET /businesses/:business_id/products/:product_id/option_groups/:option_group_id/options/:id/edit
  def edit
  end

  # POST /businesses/:business_id/products/:product_id/option_groups/:option_group_id/options
  def create
    respond_to do |format|
      if @option.save
        format.turbo_stream { flash.now[:notice] = "Option was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/products/:product_id/option_groups/:option_group_id/options/:id
  def update
    respond_to do |format|
      if @option.update(option_params)
        format.turbo_stream { flash.now[:notice] = "Option was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/products/:product_id/option_groups/:option_group_id/options/:id
  def destroy
    respond_to do |format|
      if @option.destroy
        format.turbo_stream { flash.now[:notice] = "Option was successfully destroyed." }
      else
        format.turbo_stream do
          flash.now[:alert] = @option.errors.full_messages.to_sentence

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

  def set_option_group
    @option_group = @product.option_groups.find(params.expect(:option_group_id))
  end

  def build_option_with_params
    @option = @option_group.options.build(option_params)
  end

  def set_option
    @option = @option_group.options.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_params
    params.expect(option: [ :name, :price_variation, :visible ])
  end
end
