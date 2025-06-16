class BusinessesController < ApplicationController
  before_action :set_business, only: %i[ show edit update destroy ]

  before_action :restrict_business_creation, only: %i[ new create ]

  # GET /business/new
  def new
    @business = current_user.build_business
  end

  # GET /business
  def show
  end

  # GET /business/edit
  def edit
  end

  # POST /business
  def create
    @business = current_user.build_business(business_params)

    respond_to do |format|
      if @business.save
        format.html { redirect_to root_path, notice: "Business was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: "Business was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business
  def destroy
    respond_to do |format|
      if @business.destroy
        format.html { redirect_to root_path, status: :see_other, notice: "Business was successfully destroyed." }
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
    @business = current_business
  end

  # Only allow a list of trusted parameters through.
  def business_params
    params.expect(business: [ :description, :name, :slug, :visible ])
  end

  def restrict_business_creation
    redirect_to root_path, alert: "You already have a business." if current_business.present?
  end
end
