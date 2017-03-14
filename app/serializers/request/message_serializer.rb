class Request::MessageSerializer < ActiveModel::Serializer
  attributes *(Request::Message.attribute_names - [])
end