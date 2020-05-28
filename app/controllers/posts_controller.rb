class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'home/top'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :field, :content, :picture)
  end

  def correct_user
    @post = current_user.post.find_by(id: params[:id])
    redirect_to root_url if @post.nill?
  end
end
