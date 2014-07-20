class SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def new
  end

  def create
    @user = User.find_and_authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      if @user.yo_confirmed?
        redirect_to redirect_path, notice: 'Successfully logged in!'
      else
        redirect_to "TODO CONFIRM LANDING PAGE", alert: 'Please confirm using YO.'
      end
    else
      render :new
    end
  end

  def destroy
    if current_user.update_attributes(yo_confirmed: false)
      session[:user_id] = nil
    else
      redirect_to redirect_path, alert: 'Sorry something went wrong'
    end
  end


  private

  def redirect_path
    params[:redirect_path].present? params[:redirect_path] : root_path
  end
end
