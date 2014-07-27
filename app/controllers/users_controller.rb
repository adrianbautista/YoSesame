class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new(yo_username: params[:username])
    if @user.save
      @user.send_yo_link
      render text: "Success"
    else
      render text: "Failure"
    end
  end

  def create
    @user = User.new(user_params)
  end

  def edit
  end

  def update
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end

  def confirm
    user = User.find_by(token: params[:token])
    if user && user.eligible_for_authentication? && user.update_attributes(yo_confirmed: true)
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      render text: "False"
    end
  end

  private

  def user_params
    params.require(:user).permit(:yo_username)
  end
end
