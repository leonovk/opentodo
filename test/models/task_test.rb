require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'should not save without title' do
    item = Task.new
    assert_not item.save, 'Saved without a title'
  end
end
