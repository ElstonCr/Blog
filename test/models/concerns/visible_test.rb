require "test_helper"

class VisibleTest < ActiveSupport::TestCase
  test "archived? returns true when status is archived" do
    article = articles(:four)
    assert article.archived?
  end

  test "archived? returns false when status is not archived" do
    article = articles(:one)
    assert_not article.archived?
  end
end
