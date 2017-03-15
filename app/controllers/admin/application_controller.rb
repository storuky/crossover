class Admin::ApplicationController < ApplicationController
  before_action :check_access

  private
    def check_access
      if !current_user || !current_user.has_role?(:admin) && !current_user.has_role?(:support_agent)
        if request.xhr?
          render json: {redirect_to_url: sign_path(type: "in"), reload: true}
        else
          redirect_to sign_path(type: "in")
        end
      end
    end

    def set_layout
      "admin"
    end
end
