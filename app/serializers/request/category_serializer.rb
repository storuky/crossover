class Request::CategorySerializer < ActiveModel::Serializer
  attributes *(Request::Category.attribute_names - [])
end