require 'rails_helper'
require_relative "../support/devise"

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    it "returns http found" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http found" do
      post = create(:post)
      get :show, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    login_user
    it "returns http found" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    login_user
    it "returns http found" do
      post :create, params: { post: FactoryBot.attributes_for(:post) }
      expect(response).to have_http_status(:found)
    end
  end

  describe "PUT #update" do
    it "returns http found" do
      post = create(:post)
      put :update, params: { id: post.id, post: FactoryBot.attributes_for(:post) }
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET #edit" do
    it "returns http found" do
      post = create(:post)
      get :edit, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http found" do
      post = create(:post)
      delete :destroy, params: { id: post.id }
      expect(response).to have_http_status(:found)
    end
  end

end
