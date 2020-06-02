require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  it "user_idがなければ無効な状態である" do
    comment = Comment.new(user_id: nil)
    expect(comment).not_to be_valid
  end

  it "post_idがなければ無効な状態である" do
    comment = Comment.new(post_id: nil)
    expect(comment).not_to be_valid
  end
end
