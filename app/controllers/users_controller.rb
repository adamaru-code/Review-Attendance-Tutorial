class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update] # メソッドはprivateキーワード下に定義
  before_action :logged_in_user, only: [:show, :edit, :update] # メソッドはprivateキーワード下に定義
  before_action :correct_user, only: [:edit, :update] # メソッドはprivateキーワード下に定義

  def show
    # @user = User.find(params[:id])  # before_action :set_user にまとめて記述
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # 保存成功後、ログインします。
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user # 略形 redirect_to user_url(@user)
    else
      render :new
    end
  end
  
  def edit
    # @user = User.find(params[:id])  # before_action :set_user にまとめて記述
  end
  
  def update
    # @user = User.find(params[:id])  # before_action :set_user にまとめて記述
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user # 略形 redirect_to user_url(@user)
    else
      render :edit
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # beforeフィルター
    
    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end
    
    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      # @user = User.find(params[:id])
      # redirect_to(root_url) unless @user == current_user
      redirect_to(root_url) unless current_user?(@user) # app/helpers/sessions_helper.rb の current_user? を利用
    end
end