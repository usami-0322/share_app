require 'rails_helper'

RSpec.describe 'Managemants', type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user) }
  let!(:managemant) { create(:managemant, user: user) }

  before do
    sign_in user
    visit managemants_path
  end

  context "ログイン後" do
    scenario "数値入力する(成功)" do
      fill_in "予算　(変更がなければそのまま)", with: "123456"
      fill_in "managemant[result_date]", with: "2020-06-01"
      fill_in "売上入力", with: "12345"
      click_button "登録"
      expect(page).to have_content "入力しました"
      expect(page).to have_content "123456"
      expect(page).to have_content "2020-06-01"
      expect(page).to have_content "12345"
    end

    scenario "数値入力する(失敗)" do
      click_button "登録"
      expect(page).to have_content "売上を入力してください"
      expect(page).to have_content "売上日を入力してください"
    end

    scenario "自分の数値削除" do
      expect { click_link "削除" }.to change(Managemant, :count).by(-1)
    end
  end
end
