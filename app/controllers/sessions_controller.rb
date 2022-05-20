class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user # log_in(user)略形
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) # (チェックボックス実装後) 
      # remember user   #rememberヘルパーメソッド app/models/user.rb参照(チェックボックス実装前) 
      redirect_back_or user # フレンドリーフォワーディング (変更前 redirect_to user ← redirect_to(user)略形)
    else
      flash.now[:danger] ="認証に失敗しました。"
      render :new
    end
  end
  
  def destroy
  # ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
