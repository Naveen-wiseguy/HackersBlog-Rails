class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.string :url
      t.string :feed_url

      t.timestamps null: false
    end
  end
end
