require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  describe "POST #create" do
    context "承認済みユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      it "お気に入りできること" do
        favorite_params = FactoryBot.attributes_for(:favorite, post_id: @post.id, user_id: @user.id)
        sign_in @user
        post favorites_path(post_id: @post.id), params: { favorite: favorite_params }, xhr: true
        expect(response).to change(@user.favorites, :count).by(1)
      end
    end

    context "ゲストの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      it "お気に入りできないこと" do
        @other_user = build(:user, name: "example2", employee_number: "121212")
        favorite_params = FactoryBot.attributes_for(:favorite, post_id: @post.id, user_id: @user.id)
        post favorites_path(post_id: @post.id), params: { favorite: favorite_params }
        expect(response).not_to change(@other_user.favorites, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    context "承認済みユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @favorite = FactoryBot.create(:favorite, post_id: @post.id, user_id: @user.id)
      end

      it "お気に入りを取り消せること" do
        sign_in @user
        delete favorite_path(id: @favorite.id)
        expect(response).to change(@user.favorites, :count).by(-1)
      end
    end

    context "ゲストの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @favorite = FactoryBot.create(:favorite, post_id: @post.id, user_id: @user.id)
      end

      it "お気に入りを取り消せないこと" do
        @other_user = build(:user, name: "example2", employee_number: "121212")
        delete favorite_path(id: @favorite.id)
        expect(response).not_to change(@user.favorites, :count)
      end
    end
  end
end
