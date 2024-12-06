class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:bookmark, :bookmarked]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to article_path(@article)
  end

  def bookmark
    article = Article.find(params[:id])
    current_user.bookmarked_articles << article
    respond_to do |format|
      format.html { redirect_to articles_path, notice: "Saved to your bookmarks" }
      format.js { flash.now[:notice] = "Saved to your bookmarks" }
    end
  end

  def bookmarked
    @bookmarked_articles = current_user.bookmarked_articles
  end

  private

  def article_params
    params.require(:article).permit(:user, :description, :images [])
  end
end
