class Api::V1::ArticlesController < Api::V1::BaseController
  def index
    if params[:search]
      @articles=Article.title_has(params[:search]).order(views: :desc,published: :desc)
    else
      @articles=Article.order(views: :desc,published: :desc)
    end
    render(json: @articles, each_serializer: Api::V1::ArticlesSerializer)
  end

  def show
    @article=Article.find(params[:id])
    render(json: @article,serializer: Api::V1::ArticlesSerializer)
  end
end
