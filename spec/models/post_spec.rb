require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it "投稿本文、カテゴリ、タイトルがあれば有効な状態である" do
    post = Post.new(
      title: "new title",
      field: "new field",
      content: "new content",
      user: user
    )
    expect(post).to be_valid
  end

  it "投稿本文がなければ無効な状態である" do
    post = Post.new(content: nil)
    post.valid?
    expect(post.errors[:content]).to include("を入力してください")
  end

  it "カテゴリがなければ無効な状態である" do
    post = Post.new(field: nil)
    post.valid?
    expect(post.errors[:field]).to include("を入力してください")
  end

  it "タイトルがなければ無効な状態である" do
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end

  it "タイトルが50文字を越えると無効な状態である" do
    post = Post.new(title: "a" * 51)
    post.valid?
    expect(post.errors[:title]).to include("は50文字以内で入力してください")
  end
end
