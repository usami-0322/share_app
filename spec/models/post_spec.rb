require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  context "content(投稿本文),field(カテゴリ),タイトル(title)がある場合" do
    example "有効な状態である" do
      post = Post.new(
        title: "new title",
        field: "new field",
        content: "new content",
        user: user
      )
      expect(post).to be_valid
    end
  end

  describe "validates" do
    before do
      post.valid?
    end

    context "content(投稿本文)がnilの場合" do
      let(:post) { build(:post, content: nil) }

      example "エラーになる" do
        expect(post.errors[:content]).to include("を入力してください")
      end
    end

    context "field(カテゴリ)がnilの場合" do
      let(:post) { build(:post, field: nil) }

      example "エラーになる" do
        expect(post.errors[:field]).to include("を入力してください")
      end
    end

    context "タイトル(title)がなければ無効な状態である" do
      let(:post) { build(:post, title: nil) }

      example "エラーになる" do
        expect(post.errors[:title]).to include("を入力してください")
      end
    end

    context "タイトルが50文字以上の場合" do
      let(:post) { build(:post, title: "a" * 51) }

      example "エラーになる" do
        expect(post.errors[:title]).to include("は50文字以内で入力してください")
      end
    end
  end
end
