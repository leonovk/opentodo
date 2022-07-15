require "rails_helper"


RSpec.describe Room, :type => :model do

  it "validate room?" do
    should validate_presence_of(:title)
  end

  it "has many" do
    should have_many(:users)
    should have_many(:tasks)
    should have_many(:recorders)
  end
end