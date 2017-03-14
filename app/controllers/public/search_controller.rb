class Public::SearchController < Public::ApplicationController
  respond_to :json, :html

  def index
    respond_to do |format|
      format.html
      format.json {
        @requests = Request.look_for(params[:query]).where(user: current_user)
        
        response.headers['total_count'] = @requests.count
        @requests = @requests.page(params[:page]).per(30)

        render json: Oj.dump(@requests.pluck_fields)
      }
    end
  end
end
