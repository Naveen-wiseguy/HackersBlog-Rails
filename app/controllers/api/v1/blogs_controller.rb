class Api::V1::BlogsController < Api::V1::BaseController
  def index
    @blogs=Blog.all
  end

  def show
    @blog=Blog.find(params[:id])
    @articles=@blog.articles.order(views: :desc,published: :desc)
  end
end
