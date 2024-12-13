class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:first_name, :last_name, :year_of_arrival, :email, :password, :password_confirmation, :profile_pic)
  end

  def my_badges
    @user = current_user
    if current_user.user_badges.where(seen: false).any?
      current_user.user_badges.update_all(seen: true)
    end
  end
end
