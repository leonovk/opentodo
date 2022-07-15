require "rails_helper"


RSpec.describe User, :type => :model do
  it { should have_secure_password }
  it "validate user?" do
    should validate_presence_of(:login)
    should validate_presence_of(:name)
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end

  it "has many" do
    should have_many(:rooms)
    should have_many(:tasks)
    should have_many(:recorders)
  end

end