class HomeController < ApplicationController
  def top
    if user_signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @manegemant = current_user.manegemants.build
    end
  end

  def about
  end

  def policy
  end
end
