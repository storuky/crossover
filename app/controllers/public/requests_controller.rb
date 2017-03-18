class Public::RequestsController < Public::ApplicationController
  
  def index
    respond_to do |format|
      format.html
      format.json {
        @requests = current_user.requests.order("requests.updated_at DESC")

        if ["opened", "closed"].include? params[:status]
          @requests = @requests.where(status: params[:status])
        end

        response.headers['total_count'] = @requests.count
        @requests = @requests.page(params[:page]).per(30)

        render json: Oj.dump(@requests.pluck_fields([:new_messages_count_for_customer]))
      }
    end
  end

  def new

  end

  def create
    @request = current_user.requests.new request_params
    if @request.save
      render json: {redirect_to_url: public_request_path(@request), msg: "Request successfully created"}
    else
      render json: {msg: @request.errors.full_messages.join(", "), errors: @request.errors}, status: 403
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        @request = current_user.requests.find_by(id: params[:id])

        if @request
          render json: dump(@request)
        else
          render json: {msg: "Request not found", redirect_to_url: public_requests_path(status: "opened")}
        end
      }
    end
  end

  private
    def request_params
      params.require(:request).permit(:title, :category_id, messages_attributes: [:content])
    end

end
