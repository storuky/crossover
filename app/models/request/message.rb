class Request::Message < ApplicationRecord
  belongs_to :request
  belongs_to :user

  validates :content, presence: true, length: { minimum: 2 }
  validate :request_status

  before_save :strip_tags
  before_save :set_user
  after_create :ws

  class << self
    def pluck_fields fields = [], except = []
      args = [:id, :content, :created_at, "users.id", "users.name", "users.avatar_url"] + fields - except
      self.joins(:user).pluck *args
    end
  end

  def pluck_fields fields = [], except = []
    Request::Message.where(id: id).pluck_fields(fields, except).first
  end

  def ws
    RequestChannel.broadcast_to(self.user, self.pluck_fields)
    # if self.user.has_role?(:admin)
    # else
    #   User.with_role(:admin).each do |user|
    #     RequestChannel.broadcast_to(user, Request::Message.serialize(self, serializer: Request::MessageSerializer))
    #   end
    # end
  end

  private
    def strip_tags
      white_list_sanitizer = Rails::Html::WhiteListSanitizer.new
      whitelist = ['p','b','h1','h2','h3','h4','h5','h6','li','ul','ol','small','i','u', 'a', 'img']
      self.content = white_list_sanitizer.sanitize(self.content, tags: whitelist)
    end

    def set_user
      self.user = request.user if !user
    end

    def request_status
      if self.request.closed?
        errors.add("Request was closed", "")
      end
    end
end
