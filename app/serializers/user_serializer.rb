class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :avatar_url, :role

  def role
    object.roles.first.name
  end
end