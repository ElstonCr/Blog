require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @reader = users(:reader)
    @article = articles(:one)
    @comment = comments(:one)
  end

  test "should create comment when authenticated" do
    sign_in @reader
    comment_params = { comment: { commenter: "Test User", body: "This is a test comment", status: "public" } }

    assert_difference "Comment.count", 1 do
      post article_comments_url(@article), params: comment_params
    end

    assert_response :redirect
  end

  test "should reject create without authentication" do
    comment_params = { comment: { commenter: "Test", body: "Comment body", status: "public" } }

    assert_no_difference "Comment.count" do
      post article_comments_url(@article), params: comment_params
    end

    assert_redirected_to new_user_session_path
  end

  test "should not create comment with invalid data" do
    sign_in @reader
    comment_params = { comment: { commenter: "", body: "", status: "invalid_status" } }

    assert_no_difference "Comment.count" do
      post article_comments_url(@article), params: comment_params
    end

    assert_response :redirect
  end

  test "should destroy comment as admin" do
    sign_in @admin
    assert_difference "Comment.count", -1 do
      delete article_comment_url(@article, @comment)
    end

    assert_response :redirect
  end

  test "should reject destroy without authentication" do
    assert_no_difference "Comment.count" do
      delete article_comment_url(@article, @comment)
    end

    assert_redirected_to new_user_session_path
  end

  test "should reject destroy as non-admin" do
    sign_in @reader
    assert_no_difference "Comment.count" do
      delete article_comment_url(@article, @comment)
    end

    assert_redirected_to root_path
    assert_equal "Access denied. Admin privileges required.", flash[:alert]
  end
end
