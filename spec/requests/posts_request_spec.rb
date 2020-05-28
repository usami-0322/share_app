require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST #create" do
    context "承認済みのユーザーの場合" do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
        get root_path
      end

      it "正しく表示されること" do
        expect(response.status).to eq 200
      end
    end
  end
end
