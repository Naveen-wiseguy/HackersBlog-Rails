class AddPublishedDateToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :published, :datetime
  end
end
