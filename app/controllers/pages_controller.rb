class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @articles = Article.order('RANDOM()').limit(5)
    @events = Event.order('RANDOM()').limit(5)

    if params[:query].present?
      query = "%#{params[:query]}%"
      @articles = @articles.joins(:user).where(
        "articles.title ILIKE :query OR users.first_name ILIKE :query OR users.last_name ILIKE :query",
        query: query
      )
      @events = @events.joins(:user).where(
        "events.title ILIKE :query OR users.first_name ILIKE :query OR users.last_name ILIKE :query",
        query: query
      )
    end
  end

  private

  def set_search_url
    @search_url = if controller_name == 'pages'
      controller_name == 'pages'
    elsif controller_name == 'articles'
      articles_path
    elsif controller_name == 'events'
      events_path
    end
  end
end
