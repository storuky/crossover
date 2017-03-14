class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar
end