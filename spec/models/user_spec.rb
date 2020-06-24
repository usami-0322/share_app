require 'rails_helper'

RSpec.describe User, type: :model do
  context "name(名前)、employee_number(社員番号)、password(パスワード),password_confirmation(確認用パスワード)がある場合" do
    example "有効な状態である" do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  describe "validates" do
    before do
      user.valid?
    end

    context "name(名前)がnilの場合" do
      let(:user) { build(:user, name: nil) }

      example "エラーになる" do
        expect(user.errors[:name]).to include("が空になっています")
      end
    end

    context "employee_number(社員番号)がnilの場合" do
      let(:user) { build(:user, employee_number: nil) }

      example "エラーになる" do
        expect(user.errors[:employee_number]).to include("が空になっています")
      end
    end

    context "重複した社員番号の場合" do
      let(:other_user) { create(:user) }
      let(:user) { build(:user, employee_number: other_user.employee_number) }

      example "エラーになる" do
        expect(user.errors[:employee_number]).to include("はすでに存在します")
      end
    end

    context "password(パスワード)がnilの場合" do
      let(:user) { build(:user, password: nil) }

      example "エラーになる" do
        expect(user.errors[:password]).to include("が空になっています")
      end
    end

    context "パスワードと確認用パスワードが一致しない場合" do
      let(:user) { build(:user, password_confirmation: "") }

      example "エラーになる" do
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end
end
