class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.integer :views
      t.references :blog, index: true

      t.timestamps null: false
    end
    add_foreign_key :articles, :blogs
  end
end
