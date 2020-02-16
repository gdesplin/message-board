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

  describe "GET #new not logged in" do
    it "returns http found" do
      get :new
      expect(response).to redirect_to(%i[user session])
    end
  end

  describe "POST #create" do
    login_user
    it "returns http found" do
      post :create, params: { post: FactoryBot.attributes_for(:post) }
      expect(response).to have_http_status(:found)
    end
  end

  describe "POST #create not logged in" do
    it "returns http found" do
      post :create, params: { post: FactoryBot.attributes_for(:post) }
      expect(response).to redirect_to(%i[user session])
    end
  end

  describe "PUT #update" do
    login_user
    it "returns http found" do
      post = create(:post)
      put :update, params: { id: post.id, post: FactoryBot.attributes_for(:post) }
      expect(response).to have_http_status(:found)
    end
  end

  describe "PUT #update unauthorized, redirect to root" do
    login_user
    it "returns http found" do
      post = create(:post)
      user2 = create(:user, email: "tester3@test.com")
      post.update(user_id: user2.id)
      put :update, params: { id: post.id, post: FactoryBot.attributes_for(:post) }
      expect(response).to redirect_to(:root)
    end
  end

  describe "GET #edit" do
    login_user
    it "returns http found" do
      post = create(:post)
      get :edit, params: { id: post.id }
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET #edit unauthorized, redirect to root" do
    login_user
    it "returns http found" do
      user2 = create(:user, email: "tester2@test.com")
      post = create(:post)
      post.update(user_id: user2.id)
      get :edit, params: { id: post.id }
      expect(response).to redirect_to(:root)
    end
  end

  describe "DELETE #destroy" do
    login_user
    it "returns http found" do
      post = create(:post)
      delete :destroy, params: { id: post.id }
      expect(response).to have_http_status(:found)
    end
  end

  describe "DELETE #destroy unauthorized, redirect to root" do
    login_user
    it "returns http found" do
      user2 = create(:user, email: "tester2@test.com")
      post = create(:post)
      post.update(user_id: user2.id)
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(:root)
    end
  end

end
