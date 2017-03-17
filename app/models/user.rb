class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  validates :avatar, file_size: { less_than: 2.megabytes }
  validates :name, presence: true

  has_many :requests
  has_many :messages, class_name: Request::Message

  after_save :set_avatar_url
  after_save :clear_cache

  def has_access_to_admin_panel?
    Rails.cache.fetch("User(#{id}).has_access_to_admin_panel?", expires_in: 1.minute) do
      has_role?(:admin) || has_role?(:support_agent)
    end
  end

  class << self
    def pluck_fields fields = [], except = []
      args = [:id, :name, :email, :avatar_url, :banned] + fields - except
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

    def clear_cache
      Rails.cache.delete("User(#{id}).has_access_to_admin_panel?")
    end
end
