class Public::ApplicationController < ApplicationController
  before_action :check_current_user
  before_action :redirect_manager

  private
    def check_current_user
      unless current_user
        if request.xhr?
          render json: {redirect_to_url: sign_path(type: "in")}
        else
          redirect_to sign_path(type: "in")
        end
      end
    end

    def redirect_manager
      if current_user.has_access_to_admin_panel?
        if request.xhr?
          render json: {redirect_to_url: admin_requests_path, reload: true}
        else
          redirect_to admin_requests_path
        end
      end
    end

    def set_layout
      "public"
    end
end
