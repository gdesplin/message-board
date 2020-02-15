require 'rails_helper'

RSpec.describe Post, type: :model do

  before(:all) do
    @user = create(:user)
  end

  it "is valid" do
    post = build(:post, title: "Title", body: "Body", user_id: @user.id)
    expect(post).to be_valid
  end

  it "is not valid" do
    post = build(:post, title: "", body: "Body", user_id: @user.id)
    expect(post).to_not be_valid
    post = build(:post, title: "Title", body: "", user_id: @user.id)
    expect(post).to_not be_valid
    post = build(:post, title: "Title", body: "Body")
    expect(post).to_not be_valid
  end


end
