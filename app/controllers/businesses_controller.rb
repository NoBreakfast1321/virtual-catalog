class BusinessesController < ApplicationController
  include Pagy::Backend

  before_action :set_business, only: %i[ show edit update destroy ]

  # GET /businesses
  def index
    @q = current_user.businesses.ransack(params[:q])
    @pagy, @businesses = pagy(@q.result(distinct: true))
  end

  # GET /businesses/new
  def new
    @business = current_user.businesses.build
  end

  # GET /businesses/:id
  def show
  end

  # GET /businesses/:id/edit
  def edit
  end

  # POST /businesses
  def create
    @business = current_user.businesses.build(business_params)

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: "Business was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/:id
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: "Business was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/:id
  def destroy
    respond_to do |format|
      if @business.destroy
        format.html { redirect_to @business, status: :see_other, notice: "Business was successfully destroyed." }
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
    params.expect(business: [ :description, :name, :slug, :visible ])
  end
end
