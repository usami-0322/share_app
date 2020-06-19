require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  it "user_id,post_idがあれば有効な状態である" do
    favorite = Favorite.new(
      user_id: "1",
      post_id: "1",
      user: user,
      post: post
    )
    expect(favorite).to be_valid
  end

  it "user_idがなければ無効な状態である" do
    favorite = Favorite.new(user_id: nil)
    expect(favorite).not_to be_valid
  end

  it "post_idがなければ無効な状態である" do
    favorite = Favorite.new(post_id: nil)
    expect(favorite).not_to be_valid
  end
end
