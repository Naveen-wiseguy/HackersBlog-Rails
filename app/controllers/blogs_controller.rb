class BlogsController < ApplicationController
  def index
    @blogs=Blog.all
  end

  def show
    @blog=Blog.find(params[:id])
    @articles=@blog.articles.order(views: :desc,published: :desc)
  end
end
