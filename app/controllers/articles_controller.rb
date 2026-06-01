class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_article, only: [ :show, :edit, :update, :destroy ]
  before_action :require_admin, except: [ :index, :show ]

  def index
    @articles = Article.publicly_visible.order_by_created_at
  end

  def show
    redirect_to root_path, alert: "Article not found" unless @article.status == "public"
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to root_path
    end
  end

  private
    def article_params
      params.expect(article: [ :title, :body, :status ])
    end

    def load_article
      @article = Article.find(params[:id])
    end
end
