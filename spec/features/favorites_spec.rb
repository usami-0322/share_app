require 'rails_helper'

RSpec.describe 'Favorites', type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user) }
  let!(:user_post) { create(:post, field: "売上改善", title: "タイトル", content: "初投稿", user: user) }

  before do
    sign_in user
  end

  context "ログイン後" do
    scenario "投稿にいいねした後、取り消す" do
      visit root_path
      expect(page).to have_content "売上改善"
      expect(page).to have_content "タイトル"
      expect(page).to have_content "初投稿"
      expect do
        click_button "0"
      end.to change(user.likes, :count).by(1)
      expect do
        click_button "1"
      end.to change(user.likes, :count).by(-1)
    end
  end
end
