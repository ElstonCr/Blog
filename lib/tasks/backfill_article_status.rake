namespace :data do
  desc "backfill article and comments nil status to public"
  task backfill_article_status: :environment do
    articles = Article.where(status: nil)
    puts "Found #{articles.count} articles with nil status"

    updated_articles = articles.update_all(status: "public")
    puts "Updated #{updated_articles} articles"

    comments = Comment.where(status: nil)
    puts "Found #{comments.count} comments with nil status"

    updated_comments = comments.update_all(status: "public")
    puts "Updated #{updated_comments} comments"
  end
end
