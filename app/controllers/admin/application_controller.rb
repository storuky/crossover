class Admin::ApplicationController < ApplicationController
  before_action :check_admin

  private
    def check_admin
      unless current_user.admin?
        if request.xhr?
          render json: {redirect_to_url: sign_path(type: "in")}
        else
          redirect_to sign_path(type: "in")
        end
      end
    end

    def set_layout
      "admin"
    end
end
