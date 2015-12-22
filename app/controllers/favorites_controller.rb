class FavoritesController < ApplicationController
  before_action :signed_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorite!(@micropost)
  end

  def destroy
    @micropost = Favorite.find(params[:id]).tweet
    current_user.unfavorite!(@tweet)
  end
end
