require 'rails_helper'

RSpec.describe User, type: :model do

  before(:all) do
    @user = create(:user)
  end

  it "is valid" do
    expect(@user).to be_valid
  end

  it "is not valid" do
    user = build(:user, email: "")
    expect(user).to_not be_valid
  end
end
