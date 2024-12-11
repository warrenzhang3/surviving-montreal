class BadgesController < ApplicationController
  def show
    @badge = Badge.find(params[:id])
  end

  def my_badges
    @user = current_user
  end
end
