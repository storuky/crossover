class Public::HomeController < Public::ApplicationController
  
  def index
    if request.xhr?
      render json: {redirect_to_url: public_requests_path(status: "opened")}
    else
      redirect_to public_requests_path(status: "opened")
    end
  end

end
