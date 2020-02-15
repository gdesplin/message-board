require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  before(:all) do
    @user = create(:user)
    @post = create(:post, title: "Title", body: "Body", user_id: @user.id)
  end

  it "is valid" do
    comment = build(:comment, body: "Body", user_id: @user.id, post_id: @post.id)
    expect(comment).to be_valid
  end

  it "is not valid" do
    comment = build(:comment, body: "Body", user_id: @user.id)
    expect(comment).to_not be_valid
    comment = build(:comment, body: "", user_id: @user.id, post_id: @post.id)
    expect(comment).to_not be_valid
    comment = build(:comment, body: "Body", post_id: @post.id)
    expect(comment).to_not be_valid
  end
end
