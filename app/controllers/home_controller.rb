class HomeController < ApplicationController
  def top
    if user_signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @manegemant = current_user.manegemants.build
      desc_budget = current_user.manegemants.order(result_date: :desc)
      @latest_budget = desc_budget.first.budget
    end
  end

  def about
  end

  def policy
  end
end
