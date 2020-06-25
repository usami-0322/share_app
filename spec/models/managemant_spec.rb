require 'rails_helper'

RSpec.describe Managemant, type: :model do
  let!(:user) { create(:user) }

  context "user_id,budget(予算),result(売上), result_date(売上日)がある場合" do
    example "有効な状態である" do
      managemant = Managemant.new(
        user_id: "1",
        budget: "1234",
        result: "123",
        result_date: "2020-06-01",
        user: user
      )
      expect(managemant).to be_valid
    end
  end

  describe "validates" do
    before do
      managemant.valid?
    end

    context "result_date(売上日)がnilの場合" do
      let(:managemant) { build(:managemant, result_date: nil) }

      example "エラーになる" do
        expect(managemant.errors[:result_date]).to include("を入力してください")
      end
    end

    context "result(売上)がnilの場合" do
      let(:managemant) { build(:managemant, result: nil) }

      example "エラーになる" do
        expect(managemant.errors[:result]).to include("を入力してください")
      end
    end

    context "budget(予算)がなければ無効な状態である" do
      let(:managemant) { build(:managemant, budget: nil) }

      example "エラーになる" do
        expect(managemant.errors[:budget]).to include("を入力してください")
      end
    end

    context "user_idがなければ無効な状態である" do
      let(:managemant) { build(:managemant, user_id: nil) }

      example "エラーになる" do
        expect(managemant).not_to be_valid
      end
    end
  end
end
