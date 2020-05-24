require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #index" do
    context "承認済みのユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
        get users_path
      end

      it "正しく表示されること" do
        expect(response.status).to eq 200
      end

      it "ユーザー名が表示されている" do
        expect(response.body).to include "example"
      end
    end

    context "ゲストの場合" do
      before do
        get users_path
      end

      it "302レスポンスを返すこと" do
        expect(response.status).to eq 302
      end

      it "ホーム画面にリダイレクトすること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #show" do
    context "承認済みのユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
        get user_path(@user.id)
      end

      it "正常にレスポンスを返すこと" do
        expect(response.status).to eq 200
      end

      it "ユーザー情報が表示されていること" do
        expect(response.body).to include "example"
        expect(response.body).to include "1234"
      end
    end

    context "ゲストの場合" do
      before do
        @user = FactoryBot.create(:user)
        get user_path(@user.id)
      end

      it "302レスポンスを返すこと" do
        expect(response.status).to eq 302
      end

      it "ホーム画面にリダイレクトすること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #edit" do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
      get edit_user_path(@user.id)
    end

    it "正常にレスポンスを返すこと" do
      expect(response.status).to eq 200
    end
  end
end
