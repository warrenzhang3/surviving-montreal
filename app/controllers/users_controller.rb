class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:first_name, :last_name, :year_of_arrival, :email, :password, :password_confirmation, :profile_pic)
  end
end
