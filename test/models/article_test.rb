require "test_helper"
class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title or body" do
    article = Article.new
    assert_not article.save
  end

  test "should not save article with just title" do
    article = Article.new(title: "This is a Title")
    assert_not article.save
  end

  test "should not save article with just body" do
    article = Article.new(body: "This is a test body")
    assert_not article.save
  end

  test "should save article with title and body" do
    article = Article.new(title: "This is a Title", body: "This is a body", status: "public")
    assert article.save
  end

  test "should not save article with a short body" do
    article = Article.new(title: "This has a short body", body: "short", status: "public")
    assert_not article.save
  end

  test "display only public articles" do
    public_article = articles(:one)
    private_article = articles(:two)
    archived_article = articles(:four)

    visible_articles = Article.publicly_visible

    assert_includes visible_articles, public_article
    assert_not_includes visible_articles, private_article
    assert_not_includes visible_articles, archived_article
 end

 test "comments must be deleted when the article is deleted with difference approach" do
   article = articles(:one)

   assert_difference "Comment.count", -3 do
     article.destroy
   end
 end

 test "comments must be deleted when the article is deleted reload approach" do
   article = articles(:one)
   comment_ids = article.comments.pluck(:id)

   article.destroy

   comment_ids.each do |id|
     assert_nil Comment.find_by(id: id)
   end
 end
end
