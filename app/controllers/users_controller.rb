class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update] 
  before_action :logged_in_user, only: [:index,]
  before_action :from_current_user, only: [:edit, :update] 

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(5)
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
  
  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
  end
  
  def index
    @users = User.all
  end

  def index
    @users = User.page(params[:page]).per(5)
  end
  
  def favorite
    @title = 'お気に入り'
    @micropost = current_user.microposts.build
    @feed_microposts = current_user.favorite_microposts.paginate(page: params[:page])
    render template: 'home'
  end
 
  private  

  def from_current_user 
    unless current_user.try(:id) == @user.id 
      flash[:danger] = "不正なアクセス。" 
      redirect_to root_url
    end 
  end
  
  def set_user 
    @user = User.find(params[:id]) 
  end 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :region) 
  end
  
 
end