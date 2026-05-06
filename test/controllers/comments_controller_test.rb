require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_header = {
      "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(
        ENV["BLOG_ADMIN_NAME"],
        ENV["BLOG_ADMIN_PASSWORD"]
      )
    }

    @article = articles(:one)
    @comment = comments(:one)
  end

  test "should create comment" do
    comment_params = { comment: { commenter: "Test User", body: "This is a test comment", status: "public" } }

    assert_difference "Comment.count", 1 do
      post article_comments_url(@article), params: comment_params, headers: @auth_header
    end

    assert_response :redirect
  end

  test "should reject create without authentication" do
    comment_params = { comment: { commenter: "Test", body: "Comment body", status: "public" } }

    assert_no_difference "Comment.count" do
      post article_comments_url(@article), params: comment_params
    end

    assert_response :unauthorized
  end

  test "should not create comment with invalid data" do
    comment_params = { comment: { commenter: "", body: "", status: "invalid_status" } }

    assert_no_difference "Comment.count" do
      post article_comments_url(@article), params: comment_params, headers: @auth_header
    end

    assert_response :redirect
  end

  test "should destroy comment" do
    assert_difference "Comment.count", -1 do
      delete article_comment_url(@article, @comment), headers: @auth_header
    end

    assert_response :redirect
  end

  test "should reject destroy without authentication" do
    assert_no_difference "Comment.count" do
      delete article_comment_url(@article, @comment)
    end

    assert_response :unauthorized
  end
end
