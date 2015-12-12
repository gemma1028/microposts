class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update] 
  before_action :from_current_user, only: [:edit, :update] 

  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    if @user.update(user_params)
      redirect_to root_path , notice: '設定を変更しました。'
      else 
      render 'edit' 
    end 
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "twitters"
      redirect_to @user
    else
      render 'new'
    end
  end

  private  

  def from_current_user 
    unless current_user.try(:id) == @user.id 
      flash[:danger] = "ログインしてください。" 
      redirect_to root_path 
    end 
  end
  
  def set_user 
    @user = User.find(params[:id]) 
  end 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :region) 
  end
  
end