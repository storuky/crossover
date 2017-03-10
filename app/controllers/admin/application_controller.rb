class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!

  layout proc {
    if request.xhr?
      false
    else
      set_gon
      "public"
    end
  }

  private
    def set_gon
      gon.current_user = CurrentUserSerializer.new(current_user, root: false) if current_user
      gon.layout = "public"
    end
end
