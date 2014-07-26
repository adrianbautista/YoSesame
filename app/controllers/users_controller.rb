class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_yo_link
      redirect_to holding_path, alert: 'Please confirm using YO.'
    else
      render :new
    end
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
    user = User.find_by(yo_username: params[:username])
    if user && user.eligible_for_authentication && user.update_attributes(yo_confirmed: true)
      render text: "Success"
    else
      render text: "False"
    end
  end

  private

  def user_params
    params.require(:user).permit(:yo_username)
  end
end
