class HomeController < ApplicationController
  def top
    if user_signed_in?
      @post = current_user.posts.build if user_signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end

  def policy
  end
end
