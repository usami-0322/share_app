require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  context "user_id,post_idがある場合" do
    example "有効な状態である" do
      favorite = Favorite.new(
        user_id: "1",
        post_id: "1",
        user: user,
        post: post
      )
      expect(favorite).to be_valid
    end
  end

  example "user_idがなければ無効な状態である" do
    favorite = Favorite.new(user_id: nil)
    expect(favorite).not_to be_valid
  end

  example "post_idがなければ無効な状態である" do
    favorite = Favorite.new(post_id: nil)
    expect(favorite).not_to be_valid
  end
end
