class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user # log_in(user)略形
      redirect_to user # redirect_to(user)略形
    else
      flash.now[:danger] ="認証に失敗しました。"
      render :new
    end
  end
end
