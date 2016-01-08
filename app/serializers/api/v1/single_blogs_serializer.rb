class Api::V1::SingleBlogsSerializer < ActiveModel::Serializer
  attributes :id,:name,:url

  has_many :articles, serializer: Api::V1::ArticlesSerializer
end
