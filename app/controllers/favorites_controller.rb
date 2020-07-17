class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @user = current_user
    @post = Favorite.find(params[:id]).post
    current_user.unlike(@post)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
