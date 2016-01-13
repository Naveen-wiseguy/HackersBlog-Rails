class ArticlesController < ApplicationController
  def index
    if Rails.env.production?
    if params[:search]
      @articles=Article.title_has(params[:search]).order("views DESC","published DESC NULLS LAST").page(params[:page])
    else
      @articles=Article.order("views DESC","published DESC NULLS LAST").page(params[:page])
    end
  else
    if params[:search]
      @articles=Article.title_has(params[:search]).order("views DESC","published DESC").page(params[:page])
    else
      @articles=Article.order("views DESC","published DESC").page(params[:page])
    end
  end
  end

  def show
    @article=Article.find(params[:id])
    @article.views=@article.views+1
    @article.save
    redirect_to @article.url
  end
end
