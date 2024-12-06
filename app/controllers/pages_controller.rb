class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @articles = Article.order('RANDOM()').limit(5) if current_user
  end
end
