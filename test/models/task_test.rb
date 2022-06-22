require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should not save task without title" do
    task = Task.new
    assert_not task.save, "Saved the task without a title"
  end
end
