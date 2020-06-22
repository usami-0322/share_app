class HomeController < ApplicationController
  def top
    if user_signed_in?
      @post = current_user.posts.build
      if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
        @q = current_user.feed.ransack(posts_search_params)
        @feed_items = @q.result.paginate(page: params[:page])
      else
        @q = Post.none.ransack
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
      @url = root_path
    end
  end

  def about
  end

  def policy
  end
end
