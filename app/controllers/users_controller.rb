class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :likes]
  before_action :correct_user, only: [:edit, :update]

  def index
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = User.ransack(search_params)
      @title = "検索結果"
    else
      @q = User.ransack
      @title = "社員一覧"
    end
    @users = @q.result.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = @user.posts.ransack(post_search_params)
      @posts = @q.result.paginate(page: params[:page])
    else
      @q = Post.ransack
      @posts = @user.posts.paginate(page: params[:page])
    end
    @url = user_path(@user)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_with_password(user_params)
      flash[:success] = "パスワードを変更しました"
      bypass_sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def likes
    @user = User.find(params[:id])
    @posts = @user.likes.paginate(page: params[:page])
    render 'show_like'
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def search_params
    params.require(:q).permit(:name_cont)
  end
end
