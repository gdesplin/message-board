require 'rails_helper'
require_relative "../support/devise"

RSpec.describe CommentsController, type: :controller do
  describe "GET #new" do
    login_user
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    login_user
    it "returns http success" do
      comment = FactoryBot.attributes_for(:comment)
      comment[:post_id] = create(:post).id
      get :create, params: { comment: comment }
      expect(response).to have_http_status(:found)
    end
  end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
