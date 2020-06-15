require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user: user) }

  before do
    sign_in user
  end

  context "ログイン後" do
    scenario "投稿する(成功)" do
      visit root_path
      select "売上改善", from: "post[field]"
      fill_in "タイトルを入力してください(必須)", with: "タイトル"
      fill_in "投稿してください(必須)", with: "投稿テスト"
      click_button "投稿"
      expect(page).to have_content "投稿しました"
      expect(page).to have_content "タイトル:タイトル"
      expect(page).to have_content "カテゴリー:売上改善"
      expect(page).to have_content "投稿テスト"
    end

    scenario "投稿する(失敗)" do
      visit root_path
      click_button "投稿"
      expect(page).to have_content "内容を入力してください"
      expect(page).to have_content "タイトルを入力してください"
      expect(page).to have_content "カテゴリーを入力してください"
    end

    scenario "自分の投稿削除(成功)" do
      visit root_path
      expect { click_link "削除" }.to change(Post, :count).by(-1)
    end
  end
end
