require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST #create" do
    context "承認済みユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
      end

      context "有効な属性値の場合" do
        it "投稿を追加できること" do
          post_params = FactoryBot.attributes_for(:post)
          sign_in @user
          post posts_path, params: { post: post_params }
          expect(response).to change(@user.posts, :count).by(1)
        end
      end

      context "無効な属性値の場合" do
        it "投稿を追加できないこと" do
          post_params = FactoryBot.attributes_for(:post, content: nil)
          sign_in @user
          post posts_path, params: { post: post_params }
          expect(response).not_to change(@user.posts, :count)
        end
      end
    end

    context "ゲストの場合" do
      it "投稿を追加できないこと" do
        @user = build(:user)
        post_params = FactoryBot.attributes_for(:post)
        post posts_path, params: { post: post_params }
        expect(response).not_to change(@user.posts, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    context "承認済みのユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      it "投稿を削除できること" do
        sign_in @user
        delete post_path(@post)
        expect(response).to change(@user.posts, :count).by(-1)
      end
    end

    context "承認されていないユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user, name: "example2", employee_number: "121212")
        @post = FactoryBot.create(:post, user: @user)
      end

      it "投稿を削除できないこと" do
        sign_in @other_user
        delete post_path(@post)
        expect(response).not_to change(@user.posts, :count)
      end
    end

    context "ゲストの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      it "投稿を削除できないこと" do
        @other_user = build(:user, name: "example2", employee_number: "121212")
        delete post_path(@post)
        expect(response).not_to change(@user.posts, :count)
      end
    end
  end
end
