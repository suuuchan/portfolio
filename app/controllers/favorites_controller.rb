class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post=Post.find(params[:id])
    current_user.favorite(@post)
  end

  def destroy
    @post=Favorite.find(params[:id]).post
    current_user.unfavorite(@post)
  end

  private
  def favorite_params
    params.require(:favorite).permit(:user_id, :post_id)
  end

end
