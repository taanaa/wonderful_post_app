class MypageController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }
  # before_action :set_user, only: [:show]

  def index
    @articles = Article.all
    articles = current_user.articles
    articles = articles.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @articles = articles.page params[:page]
  end

  def show
    @article = Article.find_by(id: params[:id])
    @user = User.find_by(id: @article.user_id)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to articles_path, notice: t('notice.create')
    else
        render :new
    end
 end

  def update
    @article = Article.find(params[:id])
    @article.update!(article_params)
    respond_to do |format|
      format.html { redirect_to articles_url }
    end
  end

  def destroy
    @article.destroy

    if @article.destroy
      redirect_to articles_path, notice: t('notice.destroy')
    end
  end

  def search
    if params[:title].present?
      @articles = Article.where('title LIKE ?', "%#{params[:title]}%")
    else
      @articles = Article.none
    end
  end


  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def ensure_correct_user
    @article = Article.find(params[:id])
  end

    def set_user
      @article = Article.find([:id])
    end

end
