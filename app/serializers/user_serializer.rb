class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :avatar_url, :banned, :role

  def role
    object.roles&.first&.name
  end

  def avatar_url
    object.read_attribute :avatar_url
  end
end