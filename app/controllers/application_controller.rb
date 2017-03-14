class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
      gon.current_user = serialize(current_user, serializer: CurrentUserSerializer) if current_user
      gon.categories = serialize(Request::Category.all)
    end

end
