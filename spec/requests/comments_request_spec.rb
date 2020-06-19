require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST #create" do
    context "承認済みユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      context "有効な属性値の場合" do
        it "コメントできること" do
          comment_params = FactoryBot.attributes_for(:comment)
          sign_in @user
          expect do
            post post_comments_path(@post.id), params: { comment: comment_params }
          end.to change(@user.comments, :count).by(1)
        end
      end

      context "無効な属性値の場合" do
        it "コメントできないこと" do
          comment_params = FactoryBot.attributes_for(:comment, content: nil)
          sign_in @user
          expect do
            post post_comments_path(@post.id), params: { comment: comment_params }
          end.not_to change(@user.comments, :count)
        end
      end
    end

    context "ゲストユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
      end

      it "コメントできないこと" do
        @other_user = build(:user, name: "example2", employee_number: "121212")
        comment_params = FactoryBot.attributes_for(:comment)
        expect do
          post post_comments_path(@post.id), params: { comment: comment_params }
        end.not_to change(@other_user.comments, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    context "承認済みのユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @comment = FactoryBot.create(:comment, user: @user, post: @post)
      end

      it "コメントを削除できること" do
        sign_in @user
        expect do
          delete post_comment_path(@post.id, @comment.id)
        end.to change(@user.comments, :count).by(-1)
      end
    end

    context "承認されていないユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user, name: "example2", employee_number: "121212")
        @post = FactoryBot.create(:post, user: @user)
        @comment = FactoryBot.create(:comment, user: @user, post: @post)
      end

      it "コメントを削除できないこと" do
        sign_in @other_user
        expect do
          delete post_comment_path(@post.id, @comment.id)
        end.not_to change(@user.comments, :count)
      end
    end

    context "ゲストの場合" do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user)
        @comment = FactoryBot.create(:comment, user: @user, post: @post)
      end

      it "コメントを削除できないこと" do
        @other_user = build(:user, name: "example2", employee_number: "121212")
        expect do
          delete post_comment_path(@post.id, @comment.id)
        end.not_to change(@user.comments, :count)
      end
    end
  end
end
