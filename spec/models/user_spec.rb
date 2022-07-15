require "rails_helper"


RSpec.describe User, :type => :model do

  it "is not valid without a name" do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a login" do
    user = User.new(login: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end

end