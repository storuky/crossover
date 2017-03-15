class Request::Message < ApplicationRecord
  belongs_to :request, counter_cache: true
  belongs_to :user

  validates :content, presence: true, length: { minimum: 2 }
  validate :request_status

  before_create :strip_tags
  before_create :set_user
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

  def ws
    self.request.users.each do |user|
      RequestChannel.broadcast_to(user, self.pluck_fields)
    end

    User.with_role(:admin).where.not(id: self.request.user_ids).each do |user|
      RequestChannel.broadcast_to(user, self.pluck_fields)
    end
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
      if request&.closed?
        errors.add("Request was closed", "")
      end
    end
end
