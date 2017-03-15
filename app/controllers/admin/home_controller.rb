class Admin::HomeController < Admin::ApplicationController
  
  def index
    if request.xhr?
      render json: {redirect_to_url: admin_requests_path}
    else
      redirect_to admin_requests_path
    end
  end

end
