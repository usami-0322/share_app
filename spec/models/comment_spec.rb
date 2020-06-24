require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  example "コメント,post_id,user_idがあれば有効な状態である" do
    comment = Comment.new(
      content: "new content",
      user_id: "1",
      post_id: "1",
      user: user,
      post: post
    )
    expect(comment).to be_valid
  end

  example "コメントがなければ無効な状態である" do
    comment = Comment.new(content: nil)
    expect(comment).not_to be_valid
  end

  example "user_idがなければ無効な状態である" do
    comment = Comment.new(user_id: nil)
    expect(comment).not_to be_valid
  end

  example "post_idがなければ無効な状態である" do
    comment = Comment.new(post_id: nil)
    expect(comment).not_to be_valid
  end
end
