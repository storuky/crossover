class Request::Message < ApplicationRecord
  belongs_to :request, counter_cache: true, touch: true
  belongs_to :user

  validates :content, presence: true, length: { minimum: 2 }
  validate :request_status

  before_create :strip_tags
  before_create :set_user
  after_create :update_new_messages_count
  after_create :ws

  class << self
    def pluck_fields fields = [], except = []
      args = [:id, :content, :created_at, "users.id", "users.name", "users.avatar_url", :request_id] + fields - except
      self.joins(:user).pluck *args
    end
  end

  def pluck_fields fields = [], except = []
    Request::Message.where(id: id).pluck_fields(fields, except).first
  end

  private
    def ws
      request_user = request.user
      users = User.joins(:roles).where(roles: {name: ["admin", "support_agent"]}) - [request_user] + [request_user]
      users.each do |user|
        new_messages_count = user.id == request.user_id ? :new_messages_count_for_customer : :new_messages_count_for_support
        RequestChannel.broadcast_to(user, {message: self.pluck_fields, request: self.request.pluck_fields([new_messages_count])}) rescue Rails.logger.error "WS error"
      end
    end

    def strip_tags
      white_list_sanitizer = Rails::Html::WhiteListSanitizer.new
      whitelist = ['p','b','h1','h2','h3','h4','h5','h6','li','ul','ol','small','i','u', 'a', 'img']
      self.content = white_list_sanitizer.sanitize(self.content, tags: whitelist)
    end

    def set_user
      self.user_id = request.user_id if !user_id
    end

    def request_status
      if request&.closed?
        errors.add("Request was closed", "")
      end
    end

    def update_new_messages_count
      if self.user_id == request.user_id
        request.increment! :new_messages_count_for_support
      else
        request.increment! :new_messages_count_for_customer
      end
    end
end
