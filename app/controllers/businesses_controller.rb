class BusinessesController < ApplicationController
  include Pagy::Backend

  before_action :set_business, only: %i[show edit update destroy]

  # GET /businesses
  def index
    @q = current_user.businesses.ransack(params[:q])
    @pagy, @businesses = pagy(@q.result(distinct: true))
  end

  # GET /businesses/:id
  def show
  end

  # GET /businesses/new
  def new
    @business = current_user.businesses.build
  end

  # GET /businesses/:id/edit
  def edit
  end

  # POST /businesses
  def create
    @business = current_user.businesses.build(business_params)

    respond_to do |format|
      if @business.save
        format.html do
          redirect_to @business, notice: t_controller("create.success")
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:id
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html do
          redirect_to @business, notice: t_controller("update.success")
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:id
  def destroy
    respond_to do |format|
      if @business.destroy
        format.html do
          redirect_to businesses_path,
                      notice: t_controller("destroy.success"),
                      status: :see_other
        end
      else
        format.html do
          flash.now[:alert] = @business.errors.full_messages.to_sentence

          render :show, status: :unprocessable_entity
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = current_user.businesses.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def business_params
    params.expect(business: %i[description name slug visible])
  end
end
