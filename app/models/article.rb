class Article < ActiveRecord::Base
  belongs_to :blog

  scope :title_has, ->(key) {where("title LIKE ?","%#{key}%")}
end
