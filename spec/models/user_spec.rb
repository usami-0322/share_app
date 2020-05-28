require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、社員番号、パスワード,確認用パスワードがあれば有効な状態である" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "名前がなければ無効な状態である" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("が空になっています")
  end

  it "社員番号がなければ無効な状態である" do
    user = build(:user, employee_number: nil)
    user.valid?
    expect(user.errors[:employee_number]).to include("が空になっています")
  end

  it "重複した社員番号なら無効な状態である" do
    create(:user)
    user2 = build(:user)
    user2.valid?
    expect(user2.errors[:employee_number]).to include("はすでに存在します")
  end

  it "パスワードがないなら無効な状態である" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("が空になっています")
  end

  it "パスワードと確認用パスワードが一致しないなら無効な状態である" do
    user = build(:user, password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
end
