class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_article
  before_action :require_admin, only: [ :destroy ]

  def create
    @comment = @article.comments.build(comment_params)

    @comment.moderate!

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
      params.expect(comment: [ :commenter, :body, :status ])
    end

    def load_article
      @article = Article.find(params[:article_id])
    end
end
