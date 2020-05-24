require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "タイトル表示" do
    it "引数がある時page_title | base_titleと表示されること" do
      expect(helper.full_title(page_title: "test")).to match "test | GOOW"
    end

    it "引数がない場合はbase_titleが返ってくること" do
      expect(helper.full_title(page_title: "")).to match "GOOW"
    end

    it "引数がnilの場合はbase_titleが返ってくること" do
      expect(helper.full_title(page_title: nil)).to match "GOOW"
    end
  end
end
