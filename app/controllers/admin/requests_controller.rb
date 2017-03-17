class Admin::RequestsController < Admin::ApplicationController
  before_action :set_request, only: [:show, :close, :open, :read]

  def index
    respond_to do |format|
      format.html
      format.json {
        @requests = filter_requests
        
        response.headers['total_count'] = @requests.count
        @requests = @requests.page(params[:page]).per(30)

        render json: Oj.dump(@requests.pluck_fields([:new_messages_count_for_support]))
      }
      format.pdf {
        @requests = filter_requests.limit(1000)
        
        @active_categories = Request::Category.where(id: params[:category_ids]) if params[:category_ids]
        @active_user = User.find_by(id: params[:user_id]) if params[:user_id]

        render :pdf => "report", :layout => 'pdf.html.slim'
      }
      format.csv {
        @requests = filter_requests.limit(1000)
        send_data @requests.to_csv
      }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        if @request
          render json: dump(@request)
        else
          render json: {msg: "Request not found", redirect_to_url: public_requests_path(status: "opened")}
        end
      }
    end
  end

  def close
    @request.close!
    render json: {msg: "Request was successfully closed"}
  end

  def open
    @request.open!
    render json: {msg: "Request was successfully opened"}
  end

  def read
    @request.read! :support
    render json: {}
  end

  def unreaded_count
    render json: {unreaded_count: Request.unreaded.count}
  end

  private
    def set_request
      @request = Request.find(params[:id])
    end

    def filter_requests
      requests = Request.look_for(params[:query])
             .order_by(params[:sort])
             .with_status(params[:status])
             .with_categories(params.permit(category_ids: [])[:category_ids])
             .with_users([params[:user_id]])
             .between_dates(params[:date_from], params[:date_to])
      if params[:unreaded]=='true' && params[:status].downcase == 'opened'
        requests = requests.unreaded
      end

      return requests
    end
end
