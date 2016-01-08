class Api::V1::BlogsController < Api::V1::BaseController
  def index
    @blogs=Blog.all
    render(json: @blogs, each_serializer: Api::V1::BlogsSerializer)
  end

  def show
    @blog=Blog.find(params[:id])
    @articles=@blog.articles.order(views: :desc,published: :desc)
    render(json: @blog,serializer: Api::V1::SingleBlogsSerializer, root: "blog" )
  end
end
