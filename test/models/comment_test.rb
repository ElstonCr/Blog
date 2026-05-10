require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "should save comments without any parameters" do
    article = articles(:one)
    comment = article.comments.build

    assert comment.save
  end

  test "should save comment with just body" do
    article = articles(:one)
    comment = article.comments.build(body: "This is a test comment", status: "public")

    assert comment.save
  end

  test "should save comment with just commenter" do
    article = articles(:one)
    comment = article.comments.build(commenter: "Test")

    assert comment.save
  end

  test "only public comments should be visible" do
    article = articles(:one)

    public_comment = article.comments.build(body: "Public Comment", status: "public")
    private_comment = article.comments.build(body: "Private Comment", status: "private")
    archived_comment = article.comments.build(body: "Archived Comment", status: "archived")

    assert public_comment.save
    assert private_comment.save
    assert archived_comment.save

    visible_comments = article.comments.public_comments

    assert_includes visible_comments, public_comment
    assert_not_includes visible_comments, private_comment
    assert_not_includes visible_comments, archived_comment
  end

  test "only public comments should be visible using fixtures" do
    article = articles(:two)

    visible_comments = article.comments.public_comments

    assert_includes visible_comments, comments(:five)  # public
    assert_not_includes visible_comments, comments(:two)  # private
  end
end
