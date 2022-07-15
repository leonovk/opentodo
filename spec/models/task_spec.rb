require "rails_helper"


RSpec.describe Task, :type => :model do

  it "validate task?" do
    should validate_presence_of(:title)
  end

end