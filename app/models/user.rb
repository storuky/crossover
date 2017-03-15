class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  validates :avatar, file_size: { less_than: 2.megabytes }
  validates :name, presence: true, on: :update

  has_many :requests
  has_many :messages, class_name: Request::Message

  after_save :set_avatar_url

  class << self
    def pluck_fields fields = [], except = []
      args = [:id, :name, :email, :avatar_url] + fields - except
      self.pluck *args
    end

    def look_for query, params = {max_matches: 10000}
      if query.present?
        user_ids = User.search_for_ids(query, params)
        User.where(id: user_ids)
      else
        User
      end
    end
  end

  private
    def set_avatar_url
      self.update_column(:avatar_url, self.avatar.thumb.url)
    end
end
