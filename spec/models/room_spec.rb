require "rails_helper"


RSpec.describe Room, :type => :model do

  it "is not valid without a title" do
    room = Room.new(title: nil)
    expect(room).to_not be_valid
  end

end