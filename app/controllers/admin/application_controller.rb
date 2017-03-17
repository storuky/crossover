class Admin::ApplicationController < ApplicationController
  before_action :check_access

  private
    def check_access
      if !current_user || !current_user.has_access_to_admin_panel?
        if request.xhr?
          render json: {redirect_to_url: sign_path(type: "in"), reload: true}
        else
          redirect_to sign_path(type: "in")
        end
      end
    end

    def set_layout
      gon.requests_order_by = ['Unreaded first', 'Date']
      "admin"
    end
end
