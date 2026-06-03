require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @article_one = articles(:one)
    @article_two = articles(:two)
    @article_three = articles(:three)
    @article_four = articles(:four)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get show" do
    get article_path(@article_one)
    assert_response :success
  end

  test "new requires authentication" do
    get new_article_url
    assert_redirected_to new_user_session_path
  end

  test "new renders form when authenticated as admin" do
    sign_in @admin
    get new_article_url
    assert_response :success
  end

  test "should create article as admin" do
    sign_in @admin
    article_params = { article: { title: "This is a title", body: "This is a body", status: "public" } }

    assert_difference "Article.count", 1 do
      post articles_url, params: article_params
    end

    assert_response :redirect
  end

  test "edit requires authentication" do
    get edit_article_url(@article_one)
    assert_redirected_to new_user_session_path
  end

  test "edit renders form when authenticated as admin" do
    sign_in @admin
    get edit_article_url(@article_one)
    assert_response :success
  end

  test "should update article as admin" do
    sign_in @admin
    article_params = { article: { body: "This is a body was updated" } }

    patch article_path(@article_one), params: article_params
    assert_response :redirect
  end

  test "should destroy article as admin" do
    sign_in @admin
    assert_difference "Article.count", -1 do
      delete article_path(@article_one)
    end

    assert_response :redirect
  end

  test "index should show only public articles" do
    get articles_url
    assert_response :success

    assert_select "a[href=?]", article_path(@article_one), text: @article_one.title
    assert_select "a[href=?]", article_path(@article_two), false
  end

  test "should redirect show for private article" do
    get article_path(@article_two)
    assert_redirected_to root_path
  end

  test "should redirect show for archived article" do
    get article_path(@article_four)
    assert_redirected_to root_path
  end

  test "should reject create without authentication" do
    article_params = { article: { title: "Title", body: "Body content", status: "public" } }

    assert_no_difference "Article.count" do
      post articles_url, params: article_params
    end

    assert_redirected_to new_user_session_path
  end

  test "should reject update without authentication" do
    patch article_path(@article_one), params: { article: { title: "New" } }
    assert_redirected_to new_user_session_path
  end

  test "should reject destroy without authentication" do
    assert_no_difference "Article.count" do
      delete article_path(@article_one)
    end

    assert_redirected_to new_user_session_path
  end

  test "should not create article with invalid data" do
    sign_in @admin
    article_params = { article: { title: "", body: "Short", status: "public" } }

    assert_no_difference "Article.count" do
      post articles_url, params: article_params
    end

    assert_response :success
  end

  test "should not update article with invalid data" do
    sign_in @admin
    article_params = { article: { title: "" } }
    original_title = @article_one.title

    patch article_path(@article_one), params: article_params

    @article_one.reload
    assert_equal original_title, @article_one.title
    assert_response :success
  end
end
