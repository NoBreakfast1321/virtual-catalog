class OptionGroupsController < ApplicationController
  before_action :set_business
  before_action :set_product
  before_action :set_option_group, only: %i[ edit update destroy ]

  # GET /businesses/:business_id/products/:product_id/option_groups/new
  def new
    @option_group = @product.option_groups.build
  end

  # GET /businesses/:business_id/products/:product_id/option_groups/:id/edit
  def edit
  end

  # POST /businesses/:business_id/products/:product_id/option_groups
  def create
    @option_group = @product.option_groups.build(option_group_params)

    respond_to do |format|
      if @option_group.save
        format.turbo_stream { flash.now[:notice] = "Option group was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:business_id/products/:product_id/option_groups/:id
  def update
    respond_to do |format|
      if @option_group.update(option_group_params)
        format.turbo_stream { flash.now[:notice] = "Option group was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:business_id/products/:product_id/option_groups/:id
  def destroy
    respond_to do |format|
      if @option_group.destroy
        format.turbo_stream { flash.now[:notice] = "Option group was successfully destroyed." }
      else
        format.turbo_stream do
          flash.now[:alert] = @option_group.errors.full_messages.to_sentence

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
    @option_group = @product.option_groups.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def option_group_params
    params.expect(option_group: [ :max_choices, :min_choices, :name, :visible ])
  end
end
