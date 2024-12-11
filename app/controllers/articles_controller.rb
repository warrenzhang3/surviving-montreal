class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:bookmark, :bookmarked]

  def index
    @articles = Article.all
    if params[:query].present?
      query = "%#{params[:query]}%"
      @articles = @articles.joins(:user).where(
        "articles.title ILIKE :query OR users.first_name ILIKE :query OR users.last_name ILIKE :query",
        query: query
      )
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      if current_user.articles.count >= 1
        current_user.award_badge('First Article')
        current_user.check_winter_survival_badge
        flash[:notice] = "Congratulations! You've received the 'First Article' badge."
      elsif current_user.badges.where(name: ['First Article', 'Attend Your First Event', 'First Event Create']).count >= 3
        flash[:notice] = "Congratulations! You've also received the 'Survive Your First Winter' badge."
      end
      redirect_to articles_path, notice: "Article created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
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
    params.require(:article).permit(:title, :description, images: [])
  end
end
