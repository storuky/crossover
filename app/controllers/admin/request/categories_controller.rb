class Admin::Request::CategoriesController < Admin::ApplicationController
  before_action :set_category, only: [:show, :destroy, :update]

  def index
    respond_to do |format|
      format.html
      format.json {
        @categories = Request::Category.order("updated_at DESC")
        render json: Oj.dump(@categories.pluck_fields)
      }
    end
  end

  def new
  end

  def edit
  end

  def show
    render json: dump(@category)
  end

  def create
    @category = Request::Category.new(category_params)
    if @category.save
      render json: {msg: "Category successfully created", redirect_to: "admin_request_categories_path"}
    else
      render json: {msg: @category.errors.full_messages.join("; ")}, status: 403
    end
  end

  def update
    if @category.update(category_params)
      render json: {msg: "Category successfully updated", redirect_to: "admin_request_categories_path"}
    else
      render json: {msg: @category.errors.full_messages.join("; ")}, status: 403
    end
  end

  def destroy
    if @category.destroy
      render json: {msg: "Category successfully deleted", redirect_to: "admin_request_categories_path"}
    else
      render json: {msg: @category.errors.full_messages.join('; ')}, status: 403
    end
  end

  private
    def category_params
      params.require(:request_category).permit(:name)
    end

    def set_category
      @category = Request::Category.find(params[:id])
    end
end
