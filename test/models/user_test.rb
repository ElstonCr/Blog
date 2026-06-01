require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should have default role of reader" do
    user = User.new(email: "test@example.com", password: "password123")
    assert_equal "reader", user.role
  end

  test "should validate role inclusion" do
    user = User.new(email: "test@example.com", password: "password123", role: "invalid_role")
    assert_not user.valid?
    assert_includes user.errors[:role], "is not included in the list"
  end

  test "admin? returns true for admin users" do
    admin = users(:admin)
    assert admin.admin?
    assert_not admin.author?
    assert_not admin.reader?
  end

  test "author? returns true for author users" do
    author = users(:author)
    assert author.author?
    assert_not author.admin?
    assert_not author.reader?
  end

  test "reader? returns true for reader users" do
    reader = users(:reader)
    assert reader.reader?
    assert_not reader.admin?
    assert_not reader.author?
  end
end
