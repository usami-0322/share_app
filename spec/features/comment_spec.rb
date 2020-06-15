require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user) }
  let!(:post) {create(:post, user: user) }

  before do
    sign_in user
  end

  context "ログイン後" do
    scenario "コメントする(成功)" do
      visit post_path(post.id)
      expect(page).to have_content user.name
      fill_in "コメントを入力して下さい", with: "コメントする"
      click_button "コメントする"
      expect(page).to have_content "コメントしました"
      expect(page).to have_content "コメントする"
    end

    scenario "コメントする(失敗)" do
      visit post_path(post.id)
      expect(page).to have_content user.name
      click_button "コメントする"
    end

    scenario "コメント削除する"
  end
end