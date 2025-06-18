class CategoriesController < ApplicationController
  include Pagy::Backend

  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories
  def index
    @q = current_business.categories.ransack(params[:q])
    @pagy, @categories = pagy(@q.result(distinct: true))
  end

  # GET /categories/new
  def new
    @category = current_business.categories.build
  end

  # GET /categories/:id
  def show
  end

  # GET /categories/:id/edit
  def edit
  end

  # POST /categories
  def create
    @category = current_business.categories.build(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/:id
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/:id
  def destroy
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to categories_path, status: :see_other, notice: "Category was successfully destroyed." }
      else
        format.html do
          flash.now[:alert] = @category.errors.full_messages.to_sentence

          render :show, status: :unprocessable_entity
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = current_business.categories.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.expect(category: [ :description, :name, :visible ])
  end
end
