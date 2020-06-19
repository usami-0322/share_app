require 'rails_helper'

RSpec.describe Managemant, type: :model do
  let!(:user) { create(:user) }

  it "user_id,予算,売上, 売上日があれば有効な状態である" do
    managemant = Managemant.new(
      user_id: "1",
      budget: "1234",
      result: "123",
      result_date: "2020-06-01",
      user: user
    )
    expect(managemant).to be_valid
  end

  it "売上日がなければ無効な状態である" do
    managemant = Managemant.new(result_date: nil)
    managemant.valid?
    expect(managemant.errors[:result_date]).to include("を入力してください")
  end

  it "売上がなければ無効な状態である" do
    managemant = Managemant.new(result: nil)
    managemant.valid?
    expect(managemant.errors[:result]).to include("を入力してください")
  end

  it "予算がなければ無効な状態である" do
    managemant = Managemant.new(budget: nil)
    managemant.valid?
    expect(managemant.errors[:budget]).to include("を入力してください")
  end

  it "user_idがなければ無効な状態である" do
    managemant = Managemant.new(user_id: nil)
    expect(managemant).not_to be_valid
  end
end