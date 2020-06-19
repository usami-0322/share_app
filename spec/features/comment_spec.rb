require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  before do
    sign_in user
  end

  context "ログイン後" do
    scenario "コメントして削除する(成功)" do
      visit post_path(post.id)
      expect(page).to have_content user.name
      fill_in "コメントを入力して下さい", with: "コメント"
      click_button "コメントする"
      expect(page).to have_content "コメントしました"
      expect(page).to have_content "コメント"
      expect { click_on "削除" }.to change(Comment, :count).by(-1)
    end

    scenario "コメントする(失敗)" do
      visit post_path(post.id)
      expect(page).to have_content user.name
      click_button "コメントする"
      expect(page).to have_content "コメントを入力してください"
    end
  end
end
