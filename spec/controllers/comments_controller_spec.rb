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

  describe "PUT #update" do
    it "returns http found" do
      comment = create(:comment)
      put :update, params: { id: comment.id, comment: FactoryBot.attributes_for(:comment) }
      expect(response).to have_http_status(:found)
    end
  end

end
