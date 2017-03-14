class Public::ApplicationController < ApplicationController
  before_action :check_current_user

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

    def set_layout
      "public"
    end
end
