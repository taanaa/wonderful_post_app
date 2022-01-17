class ArticlesController < ApplicationController

  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  # def update
  #   # Some business logic

  #   return redirect_to:index, notice: t(".notice") if @resource.save
  #   render :edit, alert: t(".alert")
  # end

  def index
    @articles = Article.all
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

    # respond_to do |format|
    #   if @article.save
    #     format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
    #     format.json { render :show, status: :created, location: @article }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @article.errors, status: :unprocessable_entity }
    #   end
    # end
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

    # respond_to do |format|
    #   format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end



    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end

    def ensure_correct_user
      @article = Article.find(params[:id])

      # current_user はログインしていないと nil なのでエラ-する
      if (@article.user_id != current_user.id)
        flash[:notice] = "権限がありません"
        redirect_to("/articles/index")
      end
   end
end
