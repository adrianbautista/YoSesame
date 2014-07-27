class DashboardController < ApplicationController
  def index
    @user = User.where(id: session[:user_id]).first
    if !@user || !@user.yo_confirmed
      redirect_to root_path
    end
  end
end
