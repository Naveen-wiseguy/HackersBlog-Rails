class ArticlesController < ApplicationController
  def index
    @articles=Article.order(views: :desc,published: :desc)
  end

  def show
    @article=Article.find(params[:id])
    @article.views=@article.views+1
    @article.save
    redirect_to @article.url
  end
end
