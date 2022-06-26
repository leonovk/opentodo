require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save without title" do
    item = User.new
    assert_not item.save, "Saved without a title"
  end
end
