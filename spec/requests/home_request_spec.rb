require 'rails_helper'

RSpec.describe "Home page", type: :request do
  describe "GET #top" do
    it "正常にレスポンスを返すこと" do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe "GET #about" do
    it "正常にレスポンスを返すこと" do
      get about_path
      expect(response.status).to eq 200
    end
  end

  describe "GET #policy" do
    it "正常にレスポンスを返すこと" do
      get policy_path
      expect(response.status).to eq 200
    end
  end
end
