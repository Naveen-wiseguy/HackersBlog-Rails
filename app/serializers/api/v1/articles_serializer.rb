class Api::V1::ArticlesSerializer < ActiveModel::Serializer
  attributes :id,:title,:url,:published, :views
end
