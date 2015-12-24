class FavoritesController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @micropost.favorite(current_user)
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @micropost = Micropost.find(@favorite.micropost_id) 
    @micropost.unfavorite(current_user) 
  end
end
