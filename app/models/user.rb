class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  validates :avatar, file_size: { less_than: 2.megabytes }

  has_many :requests
  has_many :messages, class_name: Request::Message

  after_save :set_avatar_url


  private
    def set_avatar_url
      self.update_column(:avatar_url, self.avatar.thumb.url)
    end
end
