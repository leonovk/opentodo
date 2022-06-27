require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test 'should not save without title' do
    item = Room.new
    assert_not item.save, 'Saved without a title'
  end
end
