require 'rails_helper'

RSpec.describe "Managemants", type: :request do
  describe "GET #index" do
    context "承認済みのユーザーの場合" do
      before do
        @user = create(:user)
        sign_in @user
        get managemants_path
      end

      it "リクエストが成功すること" do
        expect(response.status).to eq 200
      end

      it "正しく表示されること" do
        expect(response.body).to include "example"
      end
    end

    context "ゲストの場合" do
      before do
        get managemants_path
      end

      it "ホーム画面にリダイレクトすること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST #create" do
    context "承認済みのユーザーの場合" do
      before do
        @user = create(:user)
      end

      it "数値入力することができる" do
        managemant_params = attributes_for(:managemant)
        sign_in @user
        expect do
          post managemants_path, params: { managemant: managemant_params }
        end.to change(@user.managemants, :count).by(1)
      end
    end

    context "承認されていないユーザーの場合" do
      before do
        @user = create(:user)
        @other_user = create(:user, name: "example2", employee_number: "121212")
      end

      it "数値入力することができない" do
        managemant_params = attributes_for(:managemant, user: @user)
        sign_in @other_user
        expect do
          post managemants_path, params: { managemant: managemant_params }
        end.not_to change(@user.managemants, :count)
      end
    end

    context "ゲストユーザーの場合" do
      before do
        @user = create(:user)
      end

      it "数値入力することができない" do
        @other_user = build(:user, name: "example2", employee_number: "121212")
        managemant_params = attributes_for(:managemant, user: @user)
        expect do
          post managemants_path, params: { managemant: managemant_params }
        end.not_to change(@user.managemants, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    context "承認済みのユーザーの場合" do
      before do
        @user = create(:user)
        @managemant = create(:managemant, user: @user)
      end

      it "数値を削除できること" do
        sign_in @user
        expect do
          delete managemant_path(@managemant.id)
        end.to change(@user.managemants, :count).by(-1)
      end
    end

    context "承認されていないユーザーの場合" do
      before do
        @user = create(:user)
        @other_user = create(:user, name: "example2", employee_number: "121212")
        @managemant = create(:managemant, user: @user)
      end

      it "数値を削除できないこと" do
        sign_in @other_user
        expect do
          delete managemant_path(@managemant.id)
        end.not_to change(@user.managemants, :count)
      end
    end

    context "ゲストユーザーの場合" do
      before do
        @user = create(:user)
        @managemant = create(:managemant, user: @user)
      end

      it "数値を削除できないこと" do
        @other_user = build(:user, name: "example2", employee_number: "121212")
        expect do
          delete managemant_path(@managemant.id)
        end.not_to change(@user.managemants, :count)
      end
    end
  end
end
