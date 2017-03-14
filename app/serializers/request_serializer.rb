class RequestSerializer < ActiveModel::Serializer
  attributes *(Request.attribute_names - [])

end