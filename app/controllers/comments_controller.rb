class CommentsController < ApplicationController
  before_action :load_article
  http_basic_authenticate_with name: ENV["BLOG_ADMIN_NAME"], password: ENV["BLOG_ADMIN_PASSWORD"], only: [ :create, :destroy ]

  def create
    @comment = @article.comments.build(comment_params)

    if @comment.save
      redirect_to article_path(@article)
    else
      redirect_to article_path(@article), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy

    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end

    def load_article
      @article = Article.find(params[:article_id])
    end
end
