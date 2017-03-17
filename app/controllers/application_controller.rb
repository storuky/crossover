class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :sign_out_if_banned

  layout proc {
    if request.xhr?
      false
    else
      set_gon
      set_layout
    end
  }

  protected
    def serialize res, options = {}
      serializer = options[:serializer] || "#{res.model_name}Serializer".constantize
      if res.respond_to?('each')
        ActiveModel::Serializer::CollectionSerializer.new(res, each_serializer: serializer, scope: self, root: false).as_json
      else
        serializer.new(res, scope: self, root: false).as_json
      end
    end

    def dump res, options = {}
      Oj.dump serialize(res, options).as_json
    end

  private
    def set_gon
      gon.current_user = serialize(current_user) if current_user
      gon.roles = ['admin', 'support_agent']
      gon.unreaded_count = Request.unreaded.count
      gon.categories = serialize(Request::Category.all)
    end

    def sign_out_if_banned
      if current_user&.banned?
        sign_out current_user

        if request.xhr?
          render json: {msg: "You was blocked", redirect_to: "root_path", reload: true}, status: 403
        else
          redirect_to root_path
        end
      end
    end

end
