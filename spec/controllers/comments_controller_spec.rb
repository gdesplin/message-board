require 'rails_helper'
require_relative "../support/devise"

RSpec.describe CommentsController, type: :controller do

  describe "POST #create" do
    login_user
    it "returns http found" do
      comment = FactoryBot.attributes_for(:comment)
      comment[:post_id] = create(:post).id
      post :create, params: { comment: comment }
      expect(response).to have_http_status(:found)
    end
  end

  describe "POST #create, not logged in" do
    it "returns http found" do
      comment = FactoryBot.attributes_for(:comment)
      comment[:post_id] = create(:post).id
      post :create, params: { comment: comment }
      expect(response).to redirect_to(%i[user session])
    end
  end

  describe "PUT #update" do
    login_user
    it "returns http found" do
      comment = create(:comment)
      put :update, params: { id: comment.id, comment: FactoryBot.attributes_for(:comment) }
      expect(response).to have_http_status(:found)
    end
  end

  describe "PUT #update unauthorized, redirect to root" do
    login_user
    it "returns http found" do
      comment = create(:comment)
      user2 = create(:user, email: "tester4@test.com")
      comment.update(user_id: user2.id)
      put :update, params: { id: comment.id, comment: FactoryBot.attributes_for(:comment) }
      expect(response).to redirect_to(:root)
    end
  end

end
