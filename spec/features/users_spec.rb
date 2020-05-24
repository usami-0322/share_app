require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { create(:user) }

  scenario "ユーザーはパスワードを編集する" do
    visit root_path
    click_link "ログイン"
    fill_in "社員番号", with: user.employee_number
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました"
    click_link "編集"
    click_link "パスワード変更はこちらから"
    fill_in "現在のパスワード", with: user.password
    fill_in "新しいパスワード", with: "newpassword"
    fill_in "新しいパスワードの確認", with: "newpassword"
    click_button "変更"
    expect(page).to have_content "パスワードを変更しました"
    expect(page).to have_content user.name
  end
end
