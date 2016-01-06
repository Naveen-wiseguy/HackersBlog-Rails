class Api::V1::BlogsSerializer < ActiveModel::Serializer
  attributes :id,:name,:url
end
