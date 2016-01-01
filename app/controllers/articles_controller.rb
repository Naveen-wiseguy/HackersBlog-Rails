class ArticlesController < ApplicationController
  def index
    @articles=Article.order(views: :desc,published: :desc).page(params[:page])
  end

  def show
    @article=Article.find(params[:id])
    @article.views=@article.views+1
    @article.save
    redirect_to @article.url
  end
end
